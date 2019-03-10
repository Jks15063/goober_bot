defmodule GooberBot.Supervisor.AgentSupervisor do
  use Supervisor

  alias GooberBot.Agent.{LobbyListAgent, PlayerQueueAgent}

  def start_link(opts \\ []) do
    options = Keyword.merge([name: __MODULE__], opts)
    Supervisor.start_link(__MODULE__, [], name: options[:name])
  end

  def init(_opts) do
    children = [
      {LobbyListAgent, []},
      {PlayerQueueAgent, []}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
