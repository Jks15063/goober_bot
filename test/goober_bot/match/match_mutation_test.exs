defmodule GooberBot.Match.MatchMutationTest do
  use GooberBot.DataCase, async: false

  alias GooberBot.Match
  alias GooberBot.Match.MatchMutation

  describe "create/1" do
    test "can create a match" do
      player1 = insert(:user)
      player2 = insert(:user)
      set = insert(:set)

      params =
        build(:match, player1_id: player1.id, player2_id: player2.id, set_id: set.id)
        |> Map.from_struct()

      {:ok, match} = MatchMutation.create(params)

      assert %Match{} = match
    end
  end
end
