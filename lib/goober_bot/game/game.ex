defmodule GooberBot.Game do
  @moduledoc """
  Game schema and changeset
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields ~w(
    name
  )a

  @optional_fields ~w()a

  schema "games" do
    field(:name, :string)
    field(:genre, :string)

    timestamps(type: :utc_datetime_usec)
  end

  def changeset(game, params) do
    game
    |> cast(params, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
  end
end
