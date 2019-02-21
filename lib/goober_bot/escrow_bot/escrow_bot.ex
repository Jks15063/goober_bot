defmodule GooberBot.EscrowBot do
  @moduledoc """
  Bot designed to facilitate money matches on discord
  """

  use GenServer
  use Nostrum.Consumer

  alias Nostrum.Api

  def start_link do
    @challenge_table :ets.new(:challenge_table, [:named_table, :private])
    # :ets.insert(:challenge_table, {:foo, true})
    # :ets.lookup(:challenge_table, :foo) |> IO.inspect()
    Consumer.start_link(__MODULE__)
  end

  # is this ever run???
  def init(_initial_state) do
    {:ok, :nostate}
  end

  def handle_event({:MESSAGE_CREATE, {msg}, _ws_state}) do
    case msg.content do
      "$eb challenge" <> challenge_txt ->
        [_full_match, challenged_user_id, dollar_amount] =
          Regex.run(~r/<@(\w+)> \$([0-9]+)/, challenge_txt)

        Api.create_message(
          msg.channel_id,
          "<@#{challenged_user_id}> has been challenged by <@#{msg.author.id}> for $#{
            dollar_amount
          }."
        )

      "$eb accept" ->
        # :ets.new(:challenge_table, [:named_table, :private])
        :ets.insert(@challenge_table, {:foo, true})

        # :ets.last(:challenge_table) |> IO.inspect()
        Api.create_message(
          msg.channel_id,
          "User <@#{msg.author.id}> has accepted a challenge from TODO"
        )

      "$eb decline" ->
        Api.create_message(
          msg.channel_id,
          "<@#{msg.author.id}> has declined a challenge from TODO"
        )

      "$eb cancel" ->
        Api.create_message(
          msg.channel_id,
          "<@#{msg.author.id}> has canceled their challenge to TODO"
        )

      "$eb report winner" <> winner ->
        Api.create_message(
          msg.channel_id,
          "#{winner} has defeated TODO and won $TODO"
        )

      "$eb help" ->
        Api.create_message(
          msg.channel_id,
          """
          Issue challenge: `$eb challenge @<username> $<dollar_amount>`.
          Example: `$eb challenge @torkable $10.00`

          Accept challenge: `$accept`

          Decline challenge: `$eb decline`

          Cancel challenge: `$eb cancel`

          Finish match: `$eb report winner @<username>`
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
