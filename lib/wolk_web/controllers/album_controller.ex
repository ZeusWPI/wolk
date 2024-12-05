defmodule WolkWeb.AlbumController do
  use WolkWeb, :controller

  alias Wolk.Albums
  alias Wolk.Albums.Album

  action_fallback WolkWeb.FallbackController

  def index(conn, _params) do
    albums = Albums.list_albums()
    render(conn, :index, albums: albums)
  end

  def create(conn, %{"album" => album_params}) do
    with {:ok, %Album{} = album} <- Albums.create_album(album_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/albums/#{album}")
      |> render(:show, album: album)
    end
  end

  def show(conn, %{"id" => id}) do
    album = Albums.get_album!(id)
    render(conn, :show, album: album)
  end

  def update(conn, %{"id" => id, "album" => album_params}) do
    album = Albums.get_album!(id)

    with {:ok, %Album{} = album} <- Albums.update_album(album, album_params) do
      render(conn, :show, album: album)
    end
  end

  def delete(conn, %{"id" => id}) do
    album = Albums.get_album!(id)

    with {:ok, %Album{}} <- Albums.delete_album(album) do
      send_resp(conn, :no_content, "")
    end
  end
end
