defmodule GooberBot.MMSupervisor do
  use Supervisor

  alias GooberBot.{EscrowBot, PlayerQueueServer}

  def start_link(opts \\ []) do
    options = Keyword.merge([name: __MODULE__], opts)
    Supervisor.start_link(__MODULE__, [], name: options[:name])
  end

  def init(_opts) do
    children = [
      {EscrowBot, []},
      {PlayerQueueServer, []}
    ]

    # children = [
    #   %{
    #     id: EscrowBot,
    #     start: {EscrowBot, :start_link, [[]]}
    #   },
    #   %{
    #     id: PlayerQueueServer,
    #     start: {PlayerQueueServer, :start_link, [[]]}
    #   }
    # ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
