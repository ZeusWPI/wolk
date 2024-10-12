defmodule Wolk.Repo.Migrations.AddHoofdjesTable do
  use Ecto.Migration

  def change do
    create table(:hoofdjes) do
      add :user_id, references(:users)
      add :kiekje_id, references(:kiekjes)
    end

    create table(:hoofdjes_kiekjes, primary_key: false) do
      add :hoofdje_id, references(:hoofdjes)
      add :kiekje_id, references(:kiekjes)
    end
  end
end
