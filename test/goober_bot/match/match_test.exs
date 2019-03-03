defmodule GooberBot.MatchTest do
  use GooberBot.DataCase, async: false

  alias GooberBot.Match

  describe "validations" do
    test "validates a match" do
      player1 = insert(:user)
      player2 = insert(:user)
      set = insert(:set)

      params =
        build(:match, player1_id: player1.id, player2_id: player2.id, set_id: set.id)
        |> Map.from_struct()

      changeset = Match.changeset(%Match{}, params)
      assert changeset.errors == []
    end
  end
end
