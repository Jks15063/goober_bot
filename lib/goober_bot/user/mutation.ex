defmodule GooberBot.User.UserMutation do
  @moduledoc "Mutations whose primary subject is a `User`"

  alias GooberBot.{Repo, User}

  @spec create(map()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def create(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end

  @spec update(User.t(), map()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def update(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
