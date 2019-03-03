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
    player1_id
    player2_id
    score_to_win
    status
  )a

  @optional_fields ~w(
    player1_score
    player2_score
  )a

  @allowed_fields @required_fields ++ @optional_fields

  schema "sets" do
    field(:player1_score, :integer, default: 0)
    field(:player2_score, :integer, default: 0)
    field(:score_to_win, :integer, default: 2)
    field(:status, SetStatus)

    belongs_to(:player1, User, type: :binary_id, foreign_key: :player1_id)
    belongs_to(:player2, User, type: :binary_id, foreign_key: :player2_id)
    has_many(:matches, Match)

    timestamps(type: :utc_datetime_usec)
  end

  def changeset(set, params) do
    set
    |> cast(params, @allowed_fields)
    |> validate_required(@required_fields)

    # |> foreign_key_constraint(:player1)
    # |> foreign_key_constraint(:player2)
  end
end
