defmodule GooberBot.PlayerQueueServer do
  use Agent

  def start_link(_) do
    # Agent.start_link(fn -> :ets.new(:player_q, []) end, name: __MODULE__)
    Agent.start_link(fn -> :queue.new() end, name: __MODULE__)
  end

  def add_player(player_id) do
    Agent.update(__MODULE__, fn queue ->
      :queue.in(player_id, queue)
    end)
  end

  def get_queue() do
    Agent.get(__MODULE__, fn q -> q end)
  end
end
