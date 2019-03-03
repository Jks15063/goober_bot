defmodule GooberBot.Set.SetMutationTest do
  use GooberBot.DataCase, async: false

  alias GooberBot.Set
  alias GooberBot.Set.SetMutation

  describe "create/1" do
    test "can create a set" do
      player1 = insert(:user)
      player2 = insert(:user)

      params =
        build(:set, player1_id: player1.id, player2_id: player2.id)
        |> Map.from_struct()

      {:ok, set} = SetMutation.create(params)

      assert %Set{} = set
    end
  end
end
