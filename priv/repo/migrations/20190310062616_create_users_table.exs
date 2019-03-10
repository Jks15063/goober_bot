defmodule GooberBot.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :bot, :boolean, default: false
      add :discord_id, :bigint
      add :discriminator, :string
      add :email, :string
      add :username, :string
      add :region_id, references(:regions, type: :uuid)
      timestamps(type: :timestamptz)
    end

    create(unique_index(:users, [:discord_id]))
  end
end
