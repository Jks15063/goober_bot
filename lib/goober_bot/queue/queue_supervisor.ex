defmodule GooberBot.Queue.QueueSupervisor do
  use Supervisor

  alias GooberBot.Queue.{LobbyQueueServer, PlayerQueueServer}

  def start_link(opts \\ []) do
    options = Keyword.merge([name: __MODULE__], opts)
    Supervisor.start_link(__MODULE__, [], name: options[:name])
  end

  def init(_opts) do
    children = [
      {PlayerQueueServer, []},
      {LobbyQueueServer, []}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
