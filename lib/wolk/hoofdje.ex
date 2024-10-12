defmodule Wolk.Hoofdje do
  use Ecto.Schema
  import Ecto.Changeset

  schema "hoofdjes" do
    has_one :claimer, User
    many_to_many :kiekjes, Kiekje, join_through: "hoofdjes_kiekjes"
  end

  def changeset(hoofdje, attrs) do
    hoofdje
    |> cast(attrs, [])
    |> validate_required([:claimer])
  end
end
