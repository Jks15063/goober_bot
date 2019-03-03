defmodule GooberBot.Set.SetQueryTest do
  use GooberBot.DataCase, async: false

  alias GooberBot.Set.SetQuery

  describe "get/1" do
    setup do
      set = insert(:set)

      %{set: set}
    end

    test "by id", %{set: set} do
      result = SetQuery.get([{:id, set.id}])
      assert result.id == set.id
    end
  end
end
