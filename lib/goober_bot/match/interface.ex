defmodule GooberBot.Match.MatchInterface do
  @moduledoc """
  Public-facing functions for working with a Match struct
  """

  alias GooberBot.Match.{MatchMutation, MatchQuery}

  defdelegate get(criteria), to: MatchQuery

  defdelegate create(params), to: MatchMutation
  defdelegate update(match, params), to: MatchMutation
end
