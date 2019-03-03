defmodule GooberBot.SetTest do
  use GooberBot.DataCase, async: false

  alias GooberBot.Set

  describe "validations" do
    test "validates a set" do
      params = %{
        score_to_win: 10,
        status: :open
      }

      changeset = Set.changeset(%Set{}, params)
      assert changeset.errors == []
    end
  end
end
