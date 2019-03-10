defmodule GooberBot.Event.EventQuery do
  @moduledoc "Queries whose primary subject is an Event"

  import Ecto.Query, only: [from: 1, from: 2]

  alias GooberBot.{Repo, Event}

  def get(criteria) do
    base_query() |> build_query(criteria) |> Repo.one()
  end

  defp base_query do
    from(event in Event)
  end

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query({:id, id}, query) do
    from(
      event in query,
      where: event.id == ^id
    )
  end

  defp compose_query({:preload, :default}, query) do
    from(
      event in query,
      preload: [:player1, :player2]
    )
  end

  defp compose_query({:player1_id, player_id}, query) do
    from(
      event in query,
      where: event.player1_id == ^player_id
    )
  end

  defp compose_query({:player2_id, player_id}, query) do
    from(
      event in query,
      where: event.player2_id == ^player_id
    )
  end

  defp compose_query({:player_id, player_id}, query) do
    from(
      event in query,
      where: event.player1_id == ^player_id or event.player2_id == ^player_id
    )
  end

  defp compose_query({:status, :active}, query) do
    from(
      event in query,
      where: event.status == "open" or event.status == "accepted" or event.status == "started"
    )
  end

  defp compose_query({:status, status}, query) do
    from(
      event in query,
      where: event.status == ^status
    )
  end
end
