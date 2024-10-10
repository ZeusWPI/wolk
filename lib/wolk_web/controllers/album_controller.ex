defmodule WolkWeb.AlbumController do
  alias Wolk.Album
  use WolkWeb, :controller
  plug WolkWeb.Plugs.RequireAuth

  def index(conn, _params) do
    render(conn, :home, layout: false)
  end

  def create(conn, _params) do
  end

  def new(conn, _params) do
  end
end
