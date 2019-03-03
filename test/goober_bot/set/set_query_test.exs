defmodule GooberBot.Set.SetQueryTest do
  use GooberBot.DataCase, async: false

  alias GooberBot.Set
  alias GooberBot.Set.SetQuery

  describe "get/1" do
    setup do
      player1 = insert(:user)
      player2 = insert(:user)
      set = insert(:set, player1: player1, player2: player2)

      %{player1: player1, set: set}
    end

    test "by player_id", %{player1: player1, set: set} do
      result = SetQuery.get([{:player_id, player1.id}])
      assert %Set{} = result
      assert result.player1_id == player1.id
    end

    # test "by status", %{player1: player1, set: set} do
    #   result = SetQuery.get([{:player_id, player1.id}])
    #   assert %User{} = result
    #   assert result.player1_id == player1.id
    # end
  end
end
