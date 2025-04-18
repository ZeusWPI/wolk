defmodule WolkWeb.Router do
  use WolkWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug WolkWeb.Plugs.SetUser
  end

  pipeline :auth_api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug WolkWeb.Plugs.SetUser
    plug WolkWeb.Plugs.RequireAuth
  end

  scope "/api", WolkWeb do
    pipe_through :auth_api

    resources "/albums", AlbumController, except: [:new, :edit]
    resources "/kiekje", KiekjeController, except: [:new, :edit]

    scope "/albums" do
      post "/:id/add/:kiekje_id", AlbumController, :link_kiekje
      get "/:id/active_months", AlbumController, :get_active_months
      get "/:id/:date", AlbumController, :get_month_kiekjes
    end

    scope "/users" do
      get "/me", UserController, :me
    end

    scope "/auth" do
      get "/logout", AuthController, :signout
    end
  end

  scope "/api/auth", WolkWeb do
    pipe_through :api

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:wolk, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: WolkWeb.Telemetry
    end
  end
end
