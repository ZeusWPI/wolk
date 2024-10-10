defmodule Wolk.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Wolk.Accounts.User
  alias Wolk.Repo

  @derive {Jason.Encoder, only: [:name, :admin]}

  schema "users" do
    field :name, :string
    field :admin, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :admin])
    |> validate_required([:name, :admin])
  end

  def findOrCreateUser(user_data) do
    changeset = changeset(%User{}, user_data)

    case Repo.get_by(User, name: changeset.changes.name) do
      nil ->
        Repo.insert(changeset)

      user ->
        {:ok, user}
    end
  end
end
