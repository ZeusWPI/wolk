defmodule Wolk.Albums do
  @moduledoc """
  The Albums context.
  """

  import Ecto.Query, warn: false
  alias Wolk.Repo

  alias Wolk.Albums.Album

  @doc """
  Returns the list of albums.

  ## Examples

      iex> list_albums()
      [%Album{}, ...]

  """
  def list_albums do
    Repo.all(Album)
  end

  @doc """
  Gets a single album.

  Raises `Ecto.NoResultsError` if the Album does not exist.

  ## Examples

      iex> get_album!(123)
      %Album{}

      iex> get_album!(456)
      ** (Ecto.NoResultsError)

  """
  def get_album!(id), do: Repo.get!(Album, id)

  @doc """
  Creates a album.

  ## Examples

      iex> create_album(%{field: value})
      {:ok, %Album{}}

      iex> create_album(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_album(attrs \\ %{}) do
    %Album{}
    |> Album.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a album.

  ## Examples

      iex> update_album(album, %{field: new_value})
      {:ok, %Album{}}

      iex> update_album(album, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_album(%Album{} = album, attrs) do
    album
    |> Album.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a album.

  ## Examples

      iex> delete_album(album)
      {:ok, %Album{}}

      iex> delete_album(album)
      {:error, %Ecto.Changeset{}}

  """
  def delete_album(%Album{} = album) do
    Repo.delete(album)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking album changes.

  ## Examples

      iex> change_album(album)
      %Ecto.Changeset{data: %Album{}}

  """
  def change_album(%Album{} = album, attrs \\ %{}) do
    Album.changeset(album, attrs)
  end

  alias Wolk.Albums.Kiekje

  @doc """
  Returns the list of kiekje.

  ## Examples

      iex> list_kiekje()
      [%Kiekje{}, ...]

  """
  def list_kiekje do
    Repo.all(Kiekje)
  end

  @doc """
  Gets a single kiekje.

  Raises `Ecto.NoResultsError` if the Kiekje does not exist.

  ## Examples

      iex> get_kiekje!(123)
      %Kiekje{}

      iex> get_kiekje!(456)
      ** (Ecto.NoResultsError)

  """
  def get_kiekje!(id), do: Repo.get!(Kiekje, id)

  @doc """
  Creates a kiekje.

  ## Examples

      iex> create_kiekje(%{field: value})
      {:ok, %Kiekje{}}

      iex> create_kiekje(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_kiekje(attrs \\ %{}) do
    %Kiekje{}
    |> Kiekje.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a kiekje.

  ## Examples

      iex> update_kiekje(kiekje, %{field: new_value})
      {:ok, %Kiekje{}}

      iex> update_kiekje(kiekje, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_kiekje(%Kiekje{} = kiekje, attrs) do
    kiekje
    |> Kiekje.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a kiekje.

  ## Examples

      iex> delete_kiekje(kiekje)
      {:ok, %Kiekje{}}

      iex> delete_kiekje(kiekje)
      {:error, %Ecto.Changeset{}}

  """
  def delete_kiekje(%Kiekje{} = kiekje) do
    Repo.delete(kiekje)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking kiekje changes.

  ## Examples

      iex> change_kiekje(kiekje)
      %Ecto.Changeset{data: %Kiekje{}}

  """
  def change_kiekje(%Kiekje{} = kiekje, attrs \\ %{}) do
    Kiekje.changeset(kiekje, attrs)
  end
end
