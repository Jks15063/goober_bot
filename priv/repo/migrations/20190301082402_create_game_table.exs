defmodule GooberBot.Repo.Migrations.CreateGameTable do
  use Ecto.Migration

  def change do
    create table(:games, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :genre, :string
    end
  end
end
