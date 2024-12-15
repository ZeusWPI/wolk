defmodule Wolk.Albums.Kiekje do
  use Ecto.Schema
  use Waffle.Ecto.Schema
  import Ecto.Changeset

  schema "kiekjes" do
    field :uploaded_by, :string
    field :image, Wolk.KiekjeImage.Type
    many_to_many :albums, Wolk.Albums.Album, join_through: "albums_kiekjes"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(kiekje, attrs) do
    kiekje
    |> cast(attrs, [:uploaded_by])
    |> validate_required([:uploaded_by])
  end

  @doc false
  def image_changeset(kiekje, attrs) do
    kiekje
    |> cast_attachments(attrs, [:image])
    |> validate_required([:image])
  end
end
