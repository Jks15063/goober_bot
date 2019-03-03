defmodule GooberBot.Participant.ParticipantQueryTest do
  use GooberBot.DataCase, async: false

  alias GooberBot.Participant.ParticipantQuery

  describe "get/1" do
    setup do
      set = insert(:set)
      user = insert(:user)
      participant = insert(:participant, set: set, user: user)

      %{participant: participant, set: set, user: user}
    end

    test "by set_id", %{participant: participant, set: set} do
      result = ParticipantQuery.get([{:set_id, set.id}])
      assert result.id == participant.id
    end

    test "by user_id", %{participant: participant, user: user} do
      result = ParticipantQuery.get([{:user_id, user.id}])
      assert result.id == participant.id
    end
  end
end
