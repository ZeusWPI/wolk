defmodule Wolk.Kiekje do
  alias Wolk.Album
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "kiekjes" do
    field :name, :string
    many_to_many :albums, Album, join_through: "albums_kiekjes"

    timestamps(type: :utc_datetime)
  end

  def changeset(kiekje, attrs) do
    kiekje
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
