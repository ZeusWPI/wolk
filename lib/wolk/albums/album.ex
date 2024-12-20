defmodule Wolk.Albums.Album do
  use Ecto.Schema
  import Ecto.Changeset

  schema "albums" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(album, attrs) do
    album
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
