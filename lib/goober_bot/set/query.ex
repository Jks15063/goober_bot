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

  defp compose_query({:owner_id, owner_id}, query) do
    from(
      set in query,
      where: set.owner_id == ^owner_id
    )
  end
end
