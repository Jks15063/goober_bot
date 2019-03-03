defmodule GooberBot.Match.MatchMutationTest do
  use GooberBot.DataCase, async: false

  alias GooberBot.Match
  alias GooberBot.Match.MatchMutation

  describe "create/1" do
    test "can create a match" do
      set = insert(:set)
      participant = insert(:participant)

      match_params =
        build(:match, set_id: set.id, participant_id: participant.id)
        |> Map.from_struct()

      {:ok, match} = MatchMutation.create(match_params)

      assert %Match{} = match
    end
  end
end
