defmodule GooberBot.User.UserQueryTest do
  use GooberBot.DataCase, async: false

  alias GooberBot.User.UserQuery

  describe "get/1" do
    setup do
      user = insert(:user)

      %{user: user}
    end

    test "by user_id", %{user: user} do
      result = UserQuery.get([{:user_id, user.user_id}])
      assert result.id == user.id
    end
  end
end
