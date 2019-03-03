defmodule GooberBot.Repo.Migrations.CreateMatchTable do
  use Ecto.Migration

  def change do
    create table(:matches, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :set_id, references(:sets, type: :uuid), null: false
      timestamps(type: :timestamptz)
    end
  end
end
