defmodule GooberBot.Repo.Migrations.CreateSetTable do
  use Ecto.Migration

  alias GooberBot.Enum.SetStatus

  def change do
    SetStatus.create_type()
    create table(:sets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :score_to_win, :bigint
      add :status, SetStatus.type()
      timestamps(type: :timestamptz)
    end
  end
end
