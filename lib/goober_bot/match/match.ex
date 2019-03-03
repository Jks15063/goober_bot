defmodule GooberBot.Match do
  @moduledoc """
  Match schema and changeset
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias GooberBot.{Set, User}

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields ~w(
    player1_id
    player2_id
    score_to_win
    set_id
  )a

  @optional_fields ~w(
    player1_score
    player2_score
  )a

  @allowed_fields @required_fields ++ @optional_fields

  schema "matches" do
    field(:player1_score, :integer, default: 0)
    field(:player2_score, :integer, default: 0)
    field(:score_to_win, :integer, default: 2)

    belongs_to(:player1, User, type: :binary_id, foreign_key: :player1_id)
    belongs_to(:player2, User, type: :binary_id, foreign_key: :player2_id)
    belongs_to(:set, Set, type: :binary_id)

    timestamps(type: :utc_datetime_usec)
  end

  def changeset(match, params) do
    match
    |> cast(params, @allowed_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:player1)
    |> foreign_key_constraint(:player2)
    |> foreign_key_constraint(:set)
  end
end
