defmodule GooberBot.Participant.ParticipantMutationTest do
  use GooberBot.DataCase, async: false

  alias GooberBot.Participant
  alias GooberBot.Participant.ParticipantMutation

  describe "create/1" do
    test "can create a participant" do
      set = insert(:set)
      user = insert(:user)

      participant_params =
        build(:participant, set_id: set.id, user_id: user.id)
        |> Map.from_struct()

      {:ok, participant} = ParticipantMutation.create(participant_params)

      assert %Participant{} = participant
    end
  end
end
