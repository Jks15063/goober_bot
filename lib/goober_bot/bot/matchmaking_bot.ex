defmodule GooberBot.Bot.MatchmakingBot do
  @moduledoc """
  Bot designed to facilitate money matches on discord
  """

  use Nostrum.Consumer

  alias Nostrum.Api
  alias GooberBot.{Event, User}
  alias GooberBot.User.UserInterface
  alias GooberBot.Event.EventInterface
  alias GooberBot.Agent.{LobbyListAgent, PlayerQueueAgent}

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, {msg}, _ws_state}) do
    handle_cmd(msg)
  end

  def handle_event(_event) do
    :noop
  end

  defp handle_cmd(%{content: "!add lobby"} = msg) do
    LobbyListAgent.add_lobby(msg.author.id)

    Api.create_message(msg.channel_id, "Lobby added")
  end

  defp handle_cmd(%{content: "!add me"} = msg) do
    PlayerQueueAgent.add_player(msg.author.id)

    Api.create_message(msg.channel_id, "Added")
  end

  defp handle_cmd(%{content: "!view q"} = msg) do
    IO.inspect(PlayerQueueAgent.get_queue())

    Api.create_message(msg.channel_id, "show q: todo")
  end

  defp handle_cmd(%{content: "!ping"} = msg) do
    user = UserInterface.get([{:discord_id, msg.author.id}])

    # event = EventInterface.get([{:player1_id, user.id}, {:status, :active}, {:preload, :default}])

    IO.inspect(msg)

    Api.create_message(
      msg.channel_id,
      "<@#{user.discord_id}> pong "
    )
  end

  defp handle_cmd(%{content: "!accept"} = msg) do
    with %User{} = user <- UserInterface.get([{:discord_id, msg.author.id}]),
         %Event{} = event <-
           EventInterface.get([{:player2_id, user.id}, {:status, :open}, {:preload, :default}]) do
      {:ok, _event} = EventInterface.update(event, %{status: :accepted})

      Api.create_message(
        msg.channel_id,
        "User <@#{msg.author.id}> has accepted a challenge from <@#{event.player1.discord_id}>"
      )
    else
      nil ->
        Api.create_message(
          msg.channel_id,
          "No open challenges."
        )
    end
  end

  defp handle_cmd(%{content: "!decline"} = msg) do
    with %User{} = user <- UserInterface.get([{:discord_id, msg.author.id}]),
         %Event{} = event <-
           EventInterface.get([{:player2_id, user.id}, {:status, :open}, {:preload, :default}]) do
      {:ok, _event} = EventInterface.update(event, %{status: :accepted})

      Api.create_message(
        msg.channel_id,
        "User <@#{msg.author.id}> has declined the challenge from <@#{event.player1.discord_id}>"
      )
    else
      nil ->
        Api.create_message(
          msg.channel_id,
          "No open challenges."
        )
    end
  end

  defp handle_cmd(%{content: "!cancel"} = msg) do
    with %User{} = user <- UserInterface.get([{:discord_id, msg.author.id}]),
         %Event{} = event <-
           EventInterface.get([{:player1_id, user.id}, {:status, :active}, {:preload, :default}]) do
      {:ok, _event} = EventInterface.update(event, %{status: :canceled})

      Api.create_message(
        msg.channel_id,
        "User <@#{msg.author.id}> has canceled their challenge to <@#{event.player2.discord_id}>"
      )
    else
      nil ->
        Api.create_message(
          msg.channel_id,
          "No open challenges."
        )
    end
  end

  defp handle_cmd(%{content: "!report" <> score_txt} = msg) do
    with %User{} = user <- UserInterface.get([{:discord_id, msg.author.id}]),
         # TODO: change :accepted to :started once that logic is in place
         %Event{} = event <-
           EventInterface.get([{:player_id, user.id}, {:status, :accepted}, {:preload, :default}]),
         [_full_match, player1_score, player2_score] <-
           Regex.run(~r/([0-9]+)-([0-9]+)/, score_txt) do
      {:ok, _event} =
        EventInterface.update(event, %{
          player1_score: player1_score,
          player2_score: player2_score,
          status: :completed
        })

      Api.create_message(
        msg.channel_id,
        "<@#{event.player1.discord_id}>: #{player1_score}, <@#{event.player2.discord_id}>: #{
          player2_score
        }"
      )
    else
      nil ->
        Api.create_message(
          msg.channel_id,
          "Oops."
        )
    end
  end

  defp handle_cmd(%{content: "!register"} = msg) do
    author =
      msg.author
      |> Map.put(:discord_id, msg.author.id)
      |> Map.delete(:id)

    case UserInterface.create(Map.from_struct(author)) do
      {:ok, _user} ->
        Api.create_message(
          msg.channel_id,
          "<@#{msg.author.id}> registered, type `!help` to see the list of commands."
        )

      {:error, changeset} ->
        handle_registration_errors(changeset.errors, msg.channel_id)
    end
  end

  defp handle_cmd(%{content: "!help"} = msg) do
    Api.create_message(
      msg.channel_id,
      """
      Issue challenge: `!challenge @<username> $<dollar_amount>`.
      Example: `!challenge @torkable $10.00`

      Accept challenge: `$accept`

      Decline challenge: `!decline`

      Cancel challenge: `!cancel`

      Finish match: `!report winner @<username>`
      """
    )
  end

  defp handle_cmd(%{content: "!challenge" <> challenge_txt} = msg) do
    author = msg.author
    challenged_user = hd(msg.mentions)
    [_full_match, score_to_win] = Regex.run(~r/ft ([0-9]+)/, challenge_txt)

    with {:p1, player1} <- {:p1, UserInterface.get([{:discord_id, author.id}])},
         {:p2, player2} <- {:p2, UserInterface.get([{:discord_id, challenged_user.id}])},
         {:p1_event, nil} <-
           {:p1_event, EventInterface.get([{:player_id, player1.id}, {:status, :active}])},
         {:p2_event, nil} <-
           {:p2_event, EventInterface.get([{:player_id, player2.id}, {:status, :active}])} do
      new_event = %{
        status: :open
      }

      {:ok, _event} = EventInterface.create(new_event)

      Api.create_message(
        msg.channel_id,
        "<@#{player2.discord_id}> has been challenged by <@#{player1.discord_id}> to a first to #{
          score_to_win
        }."
      )
    else
      {:p1, _error} ->
        Api.create_message(
          msg.channel_id,
          "<@#{author.id}> please register: `!register`"
        )

      {:p2, _error} ->
        Api.create_message(
          msg.channel_id,
          "<@#{challenged_user.username}> is not registered."
        )

      {:p1_event, %Event{}} ->
        Api.create_message(
          msg.channel_id,
          "<@#{author.id}> you can only issue one challenge at a time."
        )

      {:p2_event, %Event{}} ->
        Api.create_message(
          msg.channel_id,
          "<@#{challenged_user.username}> can only be part of one challenge at a time."
        )

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  defp handle_cmd(_) do
    :ignore
  end

  defp handle_registration_errors([discord_id: {"has already been taken", _}], channel_id) do
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
