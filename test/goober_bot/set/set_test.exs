defmodule GooberBot.SetTest do
  use GooberBot.DataCase, async: false

  alias GooberBot.Set

  describe "validations" do
    test "validates a set" do
      player1 = insert(:user)
      player2 = insert(:user)
      winner = insert(:user)

      params = %{
        matches_to_win: 10,
        status: :open,
        player1_id: player1.id,
        player2_id: player2.id,
        winner_id: winner.id
      }

      changeset = Set.changeset(%Set{}, params)
      assert changeset.errors == []
    end
  end
end
