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

  def handle_event({:MESSAGE_CREATE, {%{author: %{id: id}} = msg}, _ws_state}) do
    case msg.content do
      "$challenge" <> _ = challenge_txt ->
        ["$challenge", challenged_user, amount_str] = String.split(challenge_txt)
        amount = String.trim_leading(amount_str, "$")

        Api.create_message(
          msg.channel_id,
          "User #{challenged_user} has been challenged by <@#{id}> for $#{amount}."
        )

      "$help" ->
        Api.create_message(
          msg.channel_id,
          """
          Challenge format: `$challenge @<username> $<amount>`.
          Example: `$challenge @torkable $10.00`

          Accept challenge: `$accept challenge`
          """
        )

      _ ->
        :ignore
    end
  end

  def handle_event(_event) do
    :noop
  end
end
