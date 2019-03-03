defmodule GooberBot.Repo.Migrations.CreateSetTable do
  use Ecto.Migration

  alias GooberBot.Enum.SetStatus

  def change do
    SetStatus.create_type()
    create table(:sets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :player1_id, references(:users, type: :uuid), null: false
      add :player2_id, references(:users, type: :uuid), null: false
      add :player1_score, :bigint
      add :player2_score, :bigint
      add :score_to_win, :bigint
      add :status, SetStatus.type()
      timestamps(type: :timestamptz)
    end
  end
end
