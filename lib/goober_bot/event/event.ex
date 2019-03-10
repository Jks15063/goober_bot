defmodule GooberBot.Event do
  @moduledoc """
  Event schema and changeset
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias GooberBot.{EventParticipant, Game, User}
  alias GooberBot.Enum.EventStatus

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields ~w(
    status
  )a

  @allowed_fields ~w()a ++ @required_fields

  schema "events" do
    field(:status, EventStatus)

    belongs_to(:game, Game)
    many_to_many(:users, User, join_through: EventParticipant, on_replace: :delete)

    timestamps(type: :utc_datetime_usec)
  end

  def changeset(event, params) do
    event
    |> cast(params, @allowed_fields)
    |> validate_required(@required_fields)

    # |> cast_assoc(:event_participants)
  end
end
