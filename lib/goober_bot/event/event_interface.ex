defmodule GooberBot.Event.EventInterface do
  @moduledoc """
  Public-facing functions for working with a Event struct
  """

  alias GooberBot.Event.{EventMutation, EventQuery}

  defdelegate get(criteria), to: EventQuery

  defdelegate create(params), to: EventMutation
  defdelegate update(event, params), to: EventMutation
end
