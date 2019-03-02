defmodule GooberBot.EscrowBot do
  @moduledoc """
  Bot designed to facilitate money matches on discord
  """

  use Nostrum.Consumer

  alias Nostrum.Api
  alias GooberBot.User.UserInterface
  alias GooberBot.Set.SetInterface

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, {msg}, _ws_state}) do
    handle_cmd(msg)
  end

  def handle_event(_event) do
    :noop
  end

  defp handle_cmd(%{content: "$eb challenge" <> challenge_txt} = msg) do
    author = msg.author
    challenged_user = hd(msg.mentions)
    [_full_match, matches_to_win] = Regex.run(~r/ft ([0-9]+)/, challenge_txt)

    with {:player1, player1} <- {:player1, UserInterface.get([{:user_id, author.id}])},
         {:player2, player2} <- {:player2, UserInterface.get([{:user_id, challenged_user.id}])} do
      new_set = %{
        status: :open,
        matches_to_win: matches_to_win,
        player1_id: player1.id,
        player2_id: player2.id
      }

      {:ok, _set} = SetInterface.create(new_set)

      Api.create_message(
        msg.channel_id,
        "<@#{player2.user_id}> has been challenged by <@#{player1.user_id}> to a first to  $#{
          matches_to_win
        }."
      )
    else
      {:player1, _error} ->
        Api.create_message(
          msg.channel_id,
          "<@#{author.id}> please register: `$eb register`"
        )

      {:player2, _error} ->
        Api.create_message(
          msg.channel_id,
          "<@#{challenged_user.username}> is not registered."
        )

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  defp handle_cmd(%{content: "$eb ping"} = msg) do
    player1 = UserInterface.get([{:user_id, msg.author.id}])

    Api.create_message(
      msg.channel_id,
      "<@#{player1.user_id}> pong "
    )
  end

  defp handle_cmd(%{content: "$eb accept"} = msg) do
    Api.create_message(
      msg.channel_id,
      "User <@#{msg.author.id}> has accepted a challenge from TODO"
    )
  end

  defp handle_cmd(%{content: "$eb decline"} = msg) do
    Api.create_message(
      msg.channel_id,
      "<@#{msg.author.id}> has declined a challenge from TODO"
    )
  end

  defp handle_cmd(%{content: "$eb cancel"} = msg) do
    Api.create_message(
      msg.channel_id,
      "<@#{msg.author.id}> has canceled their challenge to TODO"
    )
  end

  defp handle_cmd(%{content: "$eb report winner" <> winner} = msg) do
    Api.create_message(
      msg.channel_id,
      "#{winner} has defeated TODO and won $TODO"
    )
  end

  defp handle_cmd(%{content: "$eb register"} = msg) do
    # IO.inspect(Map.from_struct(msg.author))

    author =
      msg.author
      |> Map.put(:user_id, msg.author.id)
      |> Map.delete(:id)

    case UserInterface.create(Map.from_struct(author)) do
      {:ok, _user} ->
        Api.create_message(
          msg.channel_id,
          "<@#{msg.author.id}> registered, type `$eb help` to see the list of commands."
        )

      {:error, changeset} ->
        handle_registration_errors(changeset.errors, msg.channel_id)
    end
  end

  defp handle_cmd(%{content: "$eb help"} = msg) do
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
  end

  defp handle_cmd(_) do
    :ignore
  end

  defp handle_registration_errors([user_id: {"has already been taken", _}], channel_id) do
    Api.create_message(
      channel_id,
      "already registered"
    )
  end

  defp handle_registration_errors(_errors, channel_id) do
    Api.create_message(
      channel_id,
      "Registration failed"
    )
  end
end
