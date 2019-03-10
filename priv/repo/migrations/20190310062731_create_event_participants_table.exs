defmodule GooberBot.Repo.Migrations.CreateEventParticipantsTable do
  use Ecto.Migration

  alias GooberBot.Enum.EventOutcome

  def change do
    EventOutcome.create_type()
    create table(:event_participants, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :character_played, :string
      add :score, :bigint
      add :event_outcome, EventOutcome.type()
      add :event_id, references(:events, type: :uuid), null: false
      add :user_id, references(:users, type: :uuid), null: false
      timestamps(type: :timestamptz)
    end
  end
end
