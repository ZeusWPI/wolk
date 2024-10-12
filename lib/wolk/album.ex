defmodule Wolk.Album do
  alias Wolk.Repo
  alias Wolk.Album
  alias Wolk.Kiekje
  use Ecto.Schema
  import Ecto.Changeset

  schema "albums" do
    field :name, :string
    many_to_many :kiekjes, Kiekje, join_through: "albums_kiekjes"

    timestamps(type: :utc_datetime)
  end

  def changeset(album, attrs) do
    album
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def create_album(attrs) do
    Album.changeset(%Album{}, attrs)
    |> Repo.insert()
  end
end
