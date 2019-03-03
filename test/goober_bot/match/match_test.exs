defmodule GooberBot.MatchTest do
  use GooberBot.DataCase, async: false

  alias GooberBot.Match

  describe "validations" do
    test "validates a match" do
      participant = insert(:participant)
      set = insert(:set)

      params = %{
        set_id: set.id,
        participant_id: participant.id
      }

      changeset = Match.changeset(%Match{}, params)
      assert changeset.errors == []
    end
  end
end
