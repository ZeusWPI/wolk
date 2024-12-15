defmodule Wolk.Repo.Migrations.CreateKiekje do
  use Ecto.Migration

  def change do
    create table(:kiekjes) do
      add :image, :string
      add :uploaded_by, :string

      timestamps(type: :utc_datetime)
    end
  end
end
