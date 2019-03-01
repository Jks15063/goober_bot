defmodule GooberBot.Match do
  @moduledoc """
  Match schema and changeset
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias GooberBot.{Set, User}

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "matches" do
    belongs_to(:set, Set)
    belongs_to(:player1, User, foreign_key: :player1_id)
    belongs_to(:player2, User, foreign_key: :player2_id)
    belongs_to(:winner, User, foreign_key: :winner_id)

    timestamps(type: :utc_datetime_usec)
  end

  def changeset(match, _params) do
    match
    |> cast_assoc(:set)
    |> cast_assoc(:player1)
    |> cast_assoc(:player2)
    |> cast_assoc(:winner)
  end
end
