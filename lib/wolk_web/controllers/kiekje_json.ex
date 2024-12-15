defmodule WolkWeb.KiekjeJSON do
  alias Wolk.Albums.Kiekje

  @doc """
  Renders a list of kiekje.
  """
  def index(%{kiekje: kiekje}) do
    %{data: for(kiekje <- kiekje, do: data(kiekje))}
  end

  @doc """
  Renders a single kiekje.
  """
  def show(%{kiekje: kiekje}) do
    %{data: data(kiekje)}
  end

  defp data(%Kiekje{} = kiekje) do
    %{
      id: kiekje.id,
      uploaded_by: kiekje.uploaded_by,
      thumbnail_url: Wolk.KiekjeImage.url({kiekje.image, kiekje}, :thumb)
    }
  end
end
