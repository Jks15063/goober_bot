defmodule GooberBot.User.UserMutation do
  @moduledoc "Mutations whose primary subject is a `User`"

  alias GooberBot.{Repo, User}

  def create(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end

  def update(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
