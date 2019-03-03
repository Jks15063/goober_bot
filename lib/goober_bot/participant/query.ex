defmodule GooberBot.Participant.ParticipantQuery do
  @moduledoc "Queries whose primary subject is a Participant"

  import Ecto.Query, only: [from: 1, from: 2]

  alias GooberBot.{Repo, Participant}

  def get(criteria) do
    base_query() |> build_query(criteria) |> Repo.one()
  end

  defp base_query do
    from(participant in Participant)
  end

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query({:set_id, set_id}, query) do
    from(
      participant in query,
      where: participant.set_id == ^set_id
    )
  end

  defp compose_query({:user_id, user_id}, query) do
    from(
      participant in query,
      where: participant.user_id == ^user_id
    )
  end
end
