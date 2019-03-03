defmodule GooberBot.SetTest do
  use GooberBot.DataCase, async: false

  alias GooberBot.Set

  describe "validations" do
    test "validates a set" do
      player1 = insert(:user)
      player2 = insert(:user)

      params =
        build(:set, player1_id: player1.id, player2_id: player2.id)
        |> Map.from_struct()

      changeset = Set.changeset(%Set{}, params)
      assert changeset.errors == []
    end
  end
end
