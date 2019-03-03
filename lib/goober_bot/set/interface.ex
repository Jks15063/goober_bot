defmodule GooberBot.Set.SetInterface do
  @moduledoc """
  Public-facing functions for working with a Set struct
  """

  alias GooberBot.Set.{SetMutation, SetQuery}

  defdelegate get(criteria), to: SetQuery

  defdelegate create(params), to: SetMutation
  defdelegate update(set, params), to: SetMutation
  # defdelegate delete(set, params), to: SetMutation
end
