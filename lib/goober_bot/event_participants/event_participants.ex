defmodule GooberBot.EventParticipant do
  @moduledoc """
  EventParticipant schema and changeset
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias GooberBot.{Event, User}
  alias GooberBot.Enum.EventOutcome

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields ~w(
    score
  )a

  @allowed_fields ~w(
    character_played
    event_outcome
  )a ++ @required_fields

  schema "event_participants" do
    field(:character_played, :string)
    field(:score, :integer)
    field(:event_outcome, EventOutcome)

    belongs_to(:event, Event)
    belongs_to(:user, User)

    timestamps(type: :utc_datetime_usec)
  end

  def changeset(event_participant, params) do
    event_participant
    |> cast(params, @allowed_fields)
    |> validate_required(@required_fields)
  end
end
