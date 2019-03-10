defmodule GooberBot.Region do
  @moduledoc """
  Region schema and changeset
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields ~w(
    name
  )a

  @allowed_fields ~w()a ++ @required_fields

  schema "regions" do
    field(:name, :string)
  end

  def changeset(region, params) do
    region
    |> cast(params, @allowed_fields)
    |> validate_required(@required_fields)
  end
end
