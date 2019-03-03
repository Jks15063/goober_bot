defmodule GooberBot.ParticipantTest do
  use GooberBot.DataCase, async: false

  alias GooberBot.Participant

  describe "validations" do
    test "validates a participant" do
      user = insert(:user)
      set = insert(:set)

      params = %{
        score: 10,
        status: "ready",
        set_id: set.id,
        user_id: user.id
      }

      changeset = Participant.changeset(%Participant{}, params)
      assert changeset.errors == []
    end
  end
end
