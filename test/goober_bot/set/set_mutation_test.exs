defmodule GooberBot.Set.SetMutationTest do
  use GooberBot.DataCase, async: false

  alias GooberBot.Set
  alias GooberBot.Set.SetMutation

  describe "create/1" do
    test "can create a set" do
      set_params =
        build(:set)
        |> Map.from_struct()

      {:ok, set} = SetMutation.create(set_params)

      assert %Set{} = set
    end
  end
end
