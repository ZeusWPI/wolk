defmodule Wolk.Albums.Album do
  use Ecto.Schema
  import Ecto.Changeset

  schema "albums" do
    field :name, :string
    many_to_many :kiekjes, Kiekje, join_through: "albums_kiekjes"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(album, attrs) do
    album
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
