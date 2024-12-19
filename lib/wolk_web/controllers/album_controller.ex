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

  def link_kiekje(conn, %{"id" => id, "kiekjes" => kiekjeIds}) do
    album = Albums.get_album_with_kiekjes!(id)
    # Check for each kiekje if it exists & filter the unexisting
    kiekjes = Enum.map(kiekjeIds, &Albums.get_kiekje(&1)) |> Enum.reject(&is_nil/1)
    kiekjes = album.kiekjes ++ kiekjes

    with {:ok, %Album{} = album} <- Albums.update_album(album, %{"kiekjes" => kiekjes}) do
      conn
      |> put_status(:created)
      |> render(:show, album: album)
    end
  end
end
