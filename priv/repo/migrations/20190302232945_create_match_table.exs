defmodule GooberBot.Repo.Migrations.CreateMatchTable do
  use Ecto.Migration

  def change do
    create table(:matches, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :player1_id, references(:users, type: :uuid), null: false
      add :player2_id, references(:users, type: :uuid), null: false
      add :player1_score, :bigint
      add :player2_score, :bigint
      add :score_to_win, :bigint
      add :set_id, references(:sets, type: :uuid), null: false
      timestamps(type: :timestamptz)
    end
  end
end
