defmodule Wolk.Repo.Migrations.AlbumKiekjes do
  use Ecto.Migration

  def change do
    create table(:album_kiekjes) do
      add :album_id, references(:albums)
      add :kiekje_id, references(:kiekjes)
    end

    create unique_index(:album_kiekjes, [:album_id, :kiekje_id])
  end
end
