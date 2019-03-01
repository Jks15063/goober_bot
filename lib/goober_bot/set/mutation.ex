defmodule GooberBot.Set.SetMutation do
  @moduledoc "Mutations whose primary subject is a Set"

  alias GooberBot.{Repo, Set}

  def create(params) do
    %Set{}
    |> Set.changeset(params)
    |> Repo.insert()
  end

  def update(set, params) do
    set
    |> Set.changeset(params)
    |> Repo.update()
  end
end
