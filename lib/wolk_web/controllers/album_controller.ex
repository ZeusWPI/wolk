defmodule WolkWeb.AlbumController do
  use WolkWeb, :controller

  alias Wolk.Albums.Kiekje
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

  def link_kiekje(conn, %{"id" => id, "kiekje_id" => kiekjeId}) do
    album = Albums.get_album!(id)

    case Albums.get_kiekje_with_albums(kiekjeId) do
      nil ->
        conn |> send_resp(:not_found, "No kiekje found for the given id")

      kiekje ->
        with {:ok, %Kiekje{}} <-
               Albums.update_kiekje(kiekje, %{"albums" => [album | kiekje.albums]}) do
          conn |> send_resp(:created, "Album & kiekje linked!")
        end
    end
  end

  def get_active_months(conn, %{"id" => id}) do
    album = Albums.get_album_with_kiekjes!(id)

    active_months =
      album.kiekjes
      |> Enum.map(& &1.inserted_at)
      |> Enum.map(fn x -> "#{x.month}-#{x.year}" end)
      |> Enum.uniq()

    render(conn, :show, active_months: active_months)
  end

  def get_month_kiekjes(conn, %{"id" => id, "date" => date}) do
    splitted_date = String.split(date, "-") |> Enum.map(&String.to_integer/1)

    case splitted_date do
      [month, year] ->
        start_date = Date.new!(year, month, 1)
        end_date = Date.shift(start_date, month: 1)

        kiekjes = Albums.get_kiekje_between_dates(id, start_date, end_date)

        render(conn, :show, kiekjes: kiekjes)

      _ ->
        conn
        |> send_resp(:bad_request, %{message: "Invalid date format"})
    end
  end
end
