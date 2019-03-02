defmodule GooberBot.Set do
  @moduledoc """
  Set schema and changeset
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias GooberBot.{Match, User}
  alias GooberBot.Enum.SetStatus

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields ~w(
    matches_to_win
    player1_id
    player2_id
    status
  )a

  @optional_fields ~w(
    winner_id
  )a

  @allowed_fields @required_fields ++ @optional_fields

  schema "sets" do
    field(:status, SetStatus)
    field(:matches_to_win, :integer)

    belongs_to(:player1, User, type: :binary_id, foreign_key: :player1_id)
    belongs_to(:player2, User, type: :binary_id, foreign_key: :player2_id)
    belongs_to(:winner, User, type: :binary_id, foreign_key: :winner_id)
    # has_many(:matches, Match)

    timestamps(type: :utc_datetime_usec)
  end

  def changeset(set, params) do
    set
    |> cast(params, @allowed_fields)
    |> validate_required(@required_fields)
    |> cast_assoc(:player1)
    |> cast_assoc(:player2)
    |> cast_assoc(:winner)
  end
end
