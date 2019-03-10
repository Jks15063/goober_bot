defmodule GooberBot.User do
  @moduledoc """
  User schema and changeset
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias GooberBot.{Event, EventParticipant, Region}

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields ~w(
    discord_id
    discriminator
    username
  )a

  @allowed_fields ~w(
    bot
    email
  )a ++ @required_fields

  schema "users" do
    field(:bot, :boolean, default: false)
    field(:discord_id, :integer)
    field(:discriminator, :string)
    field(:email, :string)
    field(:username, :string)

    belongs_to(:region, Region)
    many_to_many(:events, Event, join_through: EventParticipant, on_replace: :delete)

    timestamps(type: :utc_datetime_usec)
  end

  def changeset(user, params) do
    user
    |> cast(params, @allowed_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:discord_id)
  end
end
