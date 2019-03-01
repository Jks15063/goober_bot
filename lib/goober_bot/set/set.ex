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
    status
  )a

  @optional_fields ~w()a

  schema "sets" do
    field(:status, SetStatus)
    field(:matches_to_win, :integer)

    belongs_to(:player1, User, foreign_key: :player1_id)
    belongs_to(:player2, User, foreign_key: :player2_id)
    belongs_to(:winner, User, foreign_key: :winner_id)
    has_many(:matches, Match)

    timestamps(type: :utc_datetime_usec)
  end

  def changeset(set, params) do
    set
    |> cast(params, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:user_id)
    |> cast_assoc(:player1)
    |> cast_assoc(:player2)
    |> cast_assoc(:winner)
  end
end
