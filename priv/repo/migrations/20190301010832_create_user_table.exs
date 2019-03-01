defmodule GooberBot.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :avatar, :string
      add :bot, :boolean, default: false
      add :discriminator, :string
      add :email, :string
      add :mfa_enabled, :boolean, default: false
      add :user_id, :numeric
      add :username, :string
      add :verified, :boolean, default: false
      timestamps(type: :timestamptz)
    end

    create(unique_index(:users, [:user_id]))
  end
end
