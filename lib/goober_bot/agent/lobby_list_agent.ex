defmodule GooberBot.Agent.LobbyListAgent do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> :queue.new() end, name: __MODULE__)
  end

  def add_lobby(lobby_url) do
    Agent.update(__MODULE__, fn queue ->
      :queue.in(lobby_url, queue)
    end)
  end

  def get_queue() do
    Agent.get(__MODULE__, fn q -> q end)
  end
end
