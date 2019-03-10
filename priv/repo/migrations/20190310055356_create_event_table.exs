defmodule GooberBot.Repo.Migrations.CreateEventTable do
  use Ecto.Migration

  alias GooberBot.Enum.EventStatus

  def change do
    EventStatus.create_type()
    create table(:events, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :game_id, references(:games, type: :uuid)
      add :status, EventStatus.type()
      timestamps(type: :timestamptz)
    end
  end
end
