defmodule GooberBot.User do
  @moduledoc """
  User schema and changeset
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias GooberBot.Participant

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields ~w(
    user_id
    username
    discriminator
  )a

  @optional_fields ~w(
    avatar
    bot
    email
    mfa_enabled
    verified
  )a

  schema "users" do
    field(:avatar, :string)
    field(:bot, :boolean, default: false)
    field(:discriminator, :string)
    field(:email, :string)
    field(:mfa_enabled, :boolean, default: false)
    field(:user_id, :integer)
    field(:username, :string)
    field(:verified, :boolean, default: false)

    has_many(:participants, Participant)

    timestamps(type: :utc_datetime_usec)
  end

  def changeset(user, params) do
    user
    |> cast(params, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:user_id)
  end
end
