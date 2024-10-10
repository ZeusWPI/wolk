defmodule Wolk.Hoofdje do
  use Ecto.Schema
  import Ecto.Changeset

  schema "hoofdjes" do
    has_one :user, User
    has_one :profile, Kiekje
    many_to_many :kiekjes, Kiekje, join_through: "hoofdjes_kiekjes"
  end

  def changeset(hoofdje, attrs) do
    hoofdje
    |> cast(attrs, [])
    |> validate_required([:profile])
  end
end
