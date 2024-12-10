defmodule Wolk.Albums.Kiekje do
  use Ecto.Schema
  use Waffle.Ecto.Schema
  import Ecto.Changeset

  schema "kiekje" do
    field :name, :string
    field :image, Wolk.KiekjeImage.Type
    many_to_many :albums, Album, join_through: "albums_kiekjes"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(kiekje, attrs) do
    kiekje
    |> cast(attrs, [:name])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:name, :image])
  end
end
