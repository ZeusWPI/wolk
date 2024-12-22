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
  Gets a single album with a the kiekjes associations loaded

  Raises `Ecto.NoResultsError` if the Album does not exist.

  ## Examples

      iex> get_album_with_kiekjes!(123)
      %Album{}

      iex> get_album_with_kiekjes!(456)
      ** (Ecto.NoResultsError)

  """
  def get_album_with_kiekjes!(id) do
    Repo.get!(Album, id) |> Repo.preload(:kiekjes)
  end

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

  def update_album(%Album{} = album, %{"kiekjes" => kiekjes} = attrs) do
    album
    |> Album.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:kiekjes, kiekjes |> Enum.map(&Ecto.Changeset.change/1))
    |> Repo.update()
  end

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
  Gets a potential single kiekje.

  ## Examples

      iex> get_kiekje(123)
      %Kiekje{}

      iex> get_kiekje(456)
      ** nil

  """
  def get_kiekje(id), do: Repo.get(Kiekje, id)

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

  @doc false
  def get_kiekje_between_dates(album_id, start_date, end_date) do
    start_date = DateTime.new!(start_date, Time.new!(0, 0, 0))
    end_date = DateTime.new!(end_date, Time.new!(0, 0, 0))

    album_id =
      case album_id do
        id when is_integer(id) -> id
        id when is_binary(id) -> String.to_integer(id)
      end

    Repo.all(
      from(k in Kiekje,
        join: ak in "album_kiekjes",
        on: k.id == ak.kiekje_id,
        where:
          ak.album_id == ^album_id and ^start_date <= k.inserted_at and k.inserted_at < ^end_date,
        select: k
      )
    )
  end

  @doc """
  Creates a kiekje.

  ## Examples

      iex> create_kiekje(%{field: value})
      {:ok, %Kiekje{}}

      iex> create_kiekje(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_kiekje(attrs \\ %{}) do
    Ecto.Multi.new()
    |> Ecto.Multi.insert(:kiekje, Kiekje.changeset(%Kiekje{}, attrs))
    |> Ecto.Multi.update(:kiekje_with_image, &Kiekje.image_changeset(&1.kiekje, attrs))
    |> Repo.transaction()
    |> case do
      {:ok, %{kiekje_with_image: kiekje}} -> {:ok, kiekje}
      {:error, _, changeset, _} -> {:error, changeset}
    end
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
    |> Kiekje.image_changeset(attrs)
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
    kiekje
    |> Kiekje.changeset(attrs)
    |> Kiekje.image_changeset(attrs)
  end
end
