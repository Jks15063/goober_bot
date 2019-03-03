defmodule GooberBot.Match.MatchMutation do
  @moduledoc "Mutations whose primary subject is a `Match`"

  alias GooberBot.{Repo, Match}

  def create(params) do
    %Match{}
    |> Match.changeset(params)
    |> Repo.insert()
  end

  def update(match, params) do
    match
    |> Match.changeset(params)
    |> Repo.update()
  end
end
