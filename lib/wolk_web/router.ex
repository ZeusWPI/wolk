defmodule WolkWeb.Router do
  alias WolkWeb.AlbumLive
  use WolkWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {WolkWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug WolkWeb.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WolkWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/auth", WolkWeb do
    pipe_through :browser

    get "/logout", AuthController, :signout
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  live_session :default, on_mount: WolkWeb.UserLiveAuth do
    scope "/albums", WolkWeb.AlbumLive do
      pipe_through :browser

      live "/", Index, :index
      live "/:id", Show, :show
    end

    scope "/hoofdjes", WolkWeb do
      pipe_through :browser

      live "/", LiveHoofdje
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", WolkWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:wolk, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: WolkWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
