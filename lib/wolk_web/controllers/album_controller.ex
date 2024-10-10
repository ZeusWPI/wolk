defmodule WolkWeb.AlbumController do
  use WolkWeb, :controller
  plug WolkWeb.Plugs.RequireAuth

  def index(conn, _params) do
    render(conn, :home, layout: false)
  end
end
