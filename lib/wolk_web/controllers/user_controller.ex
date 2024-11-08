defmodule WolkWeb.UserController do
  use WolkWeb, :controller

  action_fallback WolkWeb.FallbackController

  def me(conn, _) do
    render(conn, :show, user: conn.assigns[:user])
  end
end
