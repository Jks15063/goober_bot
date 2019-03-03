defmodule GooberBot.Set do
  @moduledoc """
  Set schema and changeset
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias GooberBot.{Match, Participant}
  alias GooberBot.Enum.SetStatus

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields ~w(
    score_to_win
    status
  )a

  @optional_fields ~w(
  )a

  @allowed_fields @required_fields ++ @optional_fields

  schema "sets" do
    field(:score_to_win, :integer)
    field(:status, SetStatus)

    has_many(:matches, Match)
    has_many(:participants, Participant)

    timestamps(type: :utc_datetime_usec)
  end

  def changeset(set, params) do
    set
    |> cast(params, @allowed_fields)
    |> validate_required(@required_fields)
  end
end
