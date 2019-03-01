defmodule GooberBot.User.UserInterface do
  @moduledoc """
  Public-facing functions for working with a User struct
  """

  alias GooberBot.User.{UserMutation, UserQuery}

  defdelegate get(criteria), to: UserQuery

  defdelegate create(params), to: UserMutation
  defdelegate update(user, params), to: UserMutation
end
