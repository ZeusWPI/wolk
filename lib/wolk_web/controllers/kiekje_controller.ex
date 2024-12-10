defmodule WolkWeb.KiekjeController do
  use WolkWeb, :controller

  alias Wolk.Albums
  alias Wolk.Albums.Kiekje

  action_fallback WolkWeb.FallbackController

  def index(conn, _params) do
    kiekje = Albums.list_kiekje()
    render(conn, :index, kiekje: kiekje)
  end

  def create(conn, %{"kiekje" => kiekje_params}) do
    with {:ok, %Kiekje{} = kiekje} <- Albums.create_kiekje(kiekje_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/kiekje/#{kiekje}")
      |> render(:show, kiekje: kiekje)
    end
  end

  def show(conn, %{"id" => id}) do
    kiekje = Albums.get_kiekje!(id)
    render(conn, :show, kiekje: kiekje)
  end

  def update(conn, %{"id" => id, "kiekje" => kiekje_params}) do
    kiekje = Albums.get_kiekje!(id)

    with {:ok, %Kiekje{} = kiekje} <- Albums.update_kiekje(kiekje, kiekje_params) do
      render(conn, :show, kiekje: kiekje)
    end
  end

  def delete(conn, %{"id" => id}) do
    kiekje = Albums.get_kiekje!(id)

    with {:ok, %Kiekje{}} <- Albums.delete_kiekje(kiekje) do
      send_resp(conn, :no_content, "")
    end
  end
end
