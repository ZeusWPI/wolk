defmodule WolkWeb.AlbumJSON do
  alias Wolk.Albums.Album

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

  defp data(%Album{} = album) do
    %{
      id: album.id,
      name: album.name
    }
  end
end
