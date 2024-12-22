defmodule WolkWeb.AlbumJSON do
  alias Wolk.Albums.Album
  alias Wolk.Albums.Kiekje

  @doc """
  Renders a list of albums.
  """
  def index(%{albums: albums}) do
    %{data: for(album <- albums, do: data(album))}
  end

  @doc """
  Renders a single album.
  """
  def show(%{album: album}) do
    %{data: data(album)}
  end

  def show(%{active_months: active_months}) do
    active_months
  end

  def show(%{kiekjes: kiekjes}) do
    %{kiekjes: for(kiekje <- kiekjes, do: data(kiekje))}
  end

  defp data(%Album{} = album) do
    %{
      id: album.id,
      name: album.name
    }
  end

  defp data(%Kiekje{} = kiekje) do
    %{
      id: kiekje.id,
      uploaded_by: kiekje.uploaded_by,
      thumbnail_url: Wolk.KiekjeImage.url({kiekje.image, kiekje}, :thumb),
      url: Wolk.KiekjeImage.url({kiekje.image, kiekje}, :original)
    }
  end
end
