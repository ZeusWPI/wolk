defmodule WolkWeb.AlbumController do
  use WolkWeb, :controller

  def index(conn, _params) do
    render(conn, :home, layout: false)
  end
end
