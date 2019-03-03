defmodule GooberBot.Match.MatchQueryTest do
  use GooberBot.DataCase, async: false

  alias GooberBot.Match.MatchQuery

  describe "get/1" do
    setup do
      player1 = insert(:user)
      player2 = insert(:user)
      set = insert(:set)
      # match = insert(:match)
      match = insert(:match, player1_id: player1.id, player2_id: player2.id, set_id: set.id)

      %{match: match, set: set, player: player1}
    end

    test "by player_id", %{match: match, player: player} do
      result = MatchQuery.get([{:player_id, player.id}])
      assert result.id == match.id
    end

    test "by set_id", %{match: match, set: set} do
      result = MatchQuery.get([{:set_id, set.id}])
      assert result.id == match.id
    end
  end
end
