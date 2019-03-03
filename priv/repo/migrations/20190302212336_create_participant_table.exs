defmodule GooberBot.Repo.Migrations.CreateParticipantTable do
  use Ecto.Migration

  def change do
    create table(:participants, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :score, :bigint
      add :status, :string
      add :user_id, references(:users, type: :uuid), null: false
      add :set_id, references(:sets, type: :uuid), null: false
    end
  end
end
