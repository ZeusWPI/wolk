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

  def delete(conn, %{"id" => id}) do
    album = Albums.get_album!(id)

    with {:ok, %Album{}} <- Albums.delete_album(album) do
      send_resp(conn, :no_content, "")
    end
  end

  def link_kiekje(conn, %{"id" => id, "kiekje_id" => kiekje_id}) do
    album = Albums.get_album!(id)
    kiekje = Albums.get_kiekje!(kiekje_id)

    with {:ok, %Album{} = album} <- Albums.link_kiekje(album, kiekje) do
      conn
      |> put_status(:created)
      |> render(:show, album: album)
    end
  end
end
