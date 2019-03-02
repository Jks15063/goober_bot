defmodule GooberBot.MatchTest do
  use GooberBot.DataCase, async: false

  alias GooberBot.{Match, Set, User}

  describe "validations" do
    test "validates a match" do
      player1 = insert(:user)
      player2 = insert(:user)
      winner = insert(:user)
      set = insert(:set)

      params = %{
        player1_id: player1.id,
        player2_id: player2.id,
        winner_id: winner.id,
        set: set.id
      }

      changematch = Match.changeset(%Match{}, params)
      assert changematch.errors == []
    end
  end
end
