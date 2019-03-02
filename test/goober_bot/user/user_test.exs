defmodule GooberBot.UserTest do
  use GooberBot.DataCase, async: false

  alias GooberBot.User

  describe "validations" do
    test "validates a user" do
      params = Map.from_struct(user_factory())

      changeset = User.changeset(%User{}, params)
      assert changeset.errors == []
    end
  end
end
