defmodule GooberBot.Game do
  @moduledoc """
  Game schema and changeset
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields ~w(
    genre
    name
  )a

  @allowed_fields ~w()a ++ @required_fields

  schema "games" do
    field(:name, :string)
    field(:genre, :string)

    timestamps(type: :utc_datetime_usec)
  end

  def changeset(game, params) do
    game
    |> cast(params, @allowed_fields)
    |> validate_required(@required_fields)
  end
end
