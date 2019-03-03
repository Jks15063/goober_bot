defmodule GooberBot.Match.MatchQuery do
  @moduledoc "Queries whose primary subject is a Match"

  import Ecto.Query, only: [from: 1, from: 2]

  alias GooberBot.{Repo, Match}

  def get(criteria) do
    base_query() |> build_query(criteria) |> Repo.one()
  end

  defp base_query do
    from(match in Match)
  end

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query({:player_id, player_id}, query) do
    from(
      match in query,
      where: match.player1_id == ^player_id or match.player2_id == ^player_id
    )
  end

  defp compose_query({:set_id, set_id}, query) do
    from(
      match in query,
      where: match.set_id == ^set_id
    )
  end
end
