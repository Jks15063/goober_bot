defmodule GooberBot.Repo.Migrations.CreateSetTable do
  use Ecto.Migration

  alias GooberBot.Enum.SetStatus

  def change do
    SetStatus.create_type()
    create table(:sets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :status, SetStatus.type()
      add :matches_to_win, :integer
      add :player1_id, references(:users, type: :uuid), null: false
      add :player2_id, references(:users, type: :uuid), null: false
      add :winner_id, references(:users, type: :uuid), null: false
      timestamps(type: :timestamptz)
    end
  end
end
