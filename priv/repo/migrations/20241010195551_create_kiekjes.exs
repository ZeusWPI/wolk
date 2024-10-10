defmodule Wolk.Repo.Migrations.CreateKiekjes do
  use Ecto.Migration

  def change do
    create table(:kiekjes) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
