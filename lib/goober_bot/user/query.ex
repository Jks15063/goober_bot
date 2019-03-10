defmodule GooberBot.User.UserQuery do
  @moduledoc "Queries whose primary subject is a User"

  import Ecto.Query, only: [from: 1, from: 2]

  alias GooberBot.{Repo, User}

  def get(criteria) do
    base_query() |> build_query(criteria) |> Repo.one()
  end

  defp base_query do
    from(user in User)
  end

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query({:discord_id, discord_id}, query) do
    from(
      user in query,
      where: user.discord_id == ^discord_id
    )
  end
end
