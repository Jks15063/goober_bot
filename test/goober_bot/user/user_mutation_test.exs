defmodule GooberBot.User.UserMutationTest do
  use GooberBot.DataCase, async: false

  alias GooberBot.User
  alias GooberBot.User.UserMutation

  describe "create/1" do
    test "can create a user" do
      user_params =
        build(:user)
        |> Map.from_struct()

      {:ok, user} = UserMutation.create(user_params)

      assert %User{} = user
      assert user.username == user_params.username
    end
  end
end
