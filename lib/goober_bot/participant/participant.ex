defmodule GooberBot.Participant do
  @moduledoc """
  Participant schema and changeset
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias GooberBot.{Match, Set, User}

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields ~w(
    set_id
    user_id
  )a

  @optional_fields ~w(
    score
    status
  )a

  @allowed_fields @required_fields ++ @optional_fields

  schema "participants" do
    field(:score, :integer)
    field(:status, :string)

    belongs_to(:set, Set, type: :binary_id)
    belongs_to(:user, User, type: :binary_id)

    has_many(:matches, Match)
  end

  def changeset(participant, params) do
    participant
    |> cast(params, @allowed_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:set)
    |> foreign_key_constraint(:user)
  end
end
