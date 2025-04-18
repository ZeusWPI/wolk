defmodule Wolk.AlbumsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Wolk.Albums` context.
  """

  @doc """
  Generate a album.
  """
  def album_fixture(attrs \\ %{}) do
    {:ok, album} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Wolk.Albums.create_album()

    album
  end

  @doc """
  Generate a kiekje.
  """
  def kiekje_fixture(attrs \\ %{}) do
    {:ok, kiekje} =
      attrs
      |> Enum.into(%{
        name: "some name",
        image: "some image"
      })
      |> Wolk.Albums.create_kiekje()

    kiekje
  end
end
