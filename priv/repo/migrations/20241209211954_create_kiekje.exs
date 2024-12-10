defmodule Wolk.Repo.Migrations.CreateKiekje do
  use Ecto.Migration

  def change do
    create table(:kiekje) do
      add :name, :string
      add :image, :string

      timestamps(type: :utc_datetime)
    end
  end
end
