defmodule Wolk.Repo.Migrations.CreateAlbumsKiekjes do
  use Ecto.Migration

  def change do
    create table(:albums_kiekjes) do
      add :album_id, references(:albums)
      add :kiekje_id, references(:kiekjes)
    end

    create unique_index(:albums_kiekjes, [:album_id, :kiekje_id])
  end
end
