defmodule GooberBot.Match do
  @moduledoc """
  Match schema and changeset
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias GooberBot.Set

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields ~w(
    set_id
  )a

  @optional_fields ~w()a

  @allowed_fields @required_fields ++ @optional_fields

  schema "matches" do
    belongs_to(:set, Set, type: :binary_id)

    timestamps(type: :utc_datetime_usec)
  end

  def changeset(match, params) do
    match
    |> cast(params, @allowed_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:set)
  end
end
