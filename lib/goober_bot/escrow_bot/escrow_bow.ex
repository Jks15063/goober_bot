defmodule GooberBot.EscrowBot do
  @moduledoc """
  Bot designed to facilitate money matches on discord
  """

  use GenServer
  use Nostrum.Consumer

  alias Nostrum.Api

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def init(_initial_state) do
    {:ok, :nostate}
  end

  def handle_event({:MESSAGE_CREATE, {msg}, _ws_state}) do
    case msg.content do
      _ ->
        :ignore
    end
  end

  def handle_event(_event) do
    :noop
  end
end
