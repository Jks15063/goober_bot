defmodule GooberBot.Match.MatchQueryTest do
  use GooberBot.DataCase, async: false

  alias GooberBot.Match.MatchQuery

  describe "get/1" do
    setup do
      participant = insert(:participant)
      set = insert(:set)
      match = insert(:match, set: set, participant: participant)

      %{match: match, set: set}
    end

    test "by id", %{match: match, set: set} do
      result = MatchQuery.get([{:set_id, set.id}])
      assert result.id == match.id
    end
  end
end
