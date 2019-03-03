defmodule GooberBot.Set.SetQuery do
  @moduledoc "Queries whose primary subject is a Set"

  import Ecto.Query, only: [from: 1, from: 2]

  alias GooberBot.{Repo, Set}

  def get(criteria) do
    base_query() |> build_query(criteria) |> Repo.one()
  end

  defp base_query do
    from(set in Set)
  end

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query({:id, id}, query) do
    from(
      set in query,
      where: set.id == ^id
    )
  end

  defp compose_query({:preload, :default}, query) do
    from(
      set in query,
      preload: [:player1, :player2]
    )
  end

  defp compose_query({:player1_id, player_id}, query) do
    from(
      set in query,
      where: set.player1_id == ^player_id
    )
  end

  defp compose_query({:player2_id, player_id}, query) do
    from(
      set in query,
      where: set.player2_id == ^player_id
    )
  end

  defp compose_query({:player_id, player_id}, query) do
    from(
      set in query,
      where: set.player1_id == ^player_id or set.player2_id == ^player_id
    )
  end

  defp compose_query({:status, :active}, query) do
    from(
      set in query,
      where: set.status == "open" or set.status == "accepted" or set.status == "started"
    )
  end

  defp compose_query({:status, status}, query) do
    from(
      set in query,
      where: set.status == ^status
    )
  end
end
