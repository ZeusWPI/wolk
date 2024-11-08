defmodule WolkWeb.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "You are not authorized to access requested page.")
      |> redirect(to: "/")
      |> halt()
    end
  end
end
