defmodule GooberBot.EscrowBot do
  @moduledoc """
  Bot designed to facilitate money matches on discord
  """

  use Nostrum.Consumer

  alias Nostrum.Api
  alias GooberBot.{Set, User}
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
    [_full_match, score_to_win] = Regex.run(~r/ft ([0-9]+)/, challenge_txt)

    with {:p1, player1} <- {:p1, UserInterface.get([{:user_id, author.id}])},
         {:p2, player2} <- {:p2, UserInterface.get([{:user_id, challenged_user.id}])},
         {:p1_set, nil} <-
           {:p1_set, SetInterface.get([{:player_id, player1.id}, {:status, :active}])},
         {:p2_set, nil} <-
           {:p2_set, SetInterface.get([{:player_id, player2.id}, {:status, :active}])} do
      new_set = %{
        player1_id: player1.id,
        player2_id: player2.id,
        status: :open,
        score_to_win: score_to_win
      }

      {:ok, _set} = SetInterface.create(new_set)

      Api.create_message(
        msg.channel_id,
        "<@#{player2.user_id}> has been challenged by <@#{player1.user_id}> to a first to #{
          score_to_win
        }."
      )
    else
      {:p1, _error} ->
        Api.create_message(
          msg.channel_id,
          "<@#{author.id}> please register: `$eb register`"
        )

      {:p2, _error} ->
        Api.create_message(
          msg.channel_id,
          "<@#{challenged_user.username}> is not registered."
        )

      {:p1_set, %Set{}} ->
        Api.create_message(
          msg.channel_id,
          "<@#{author.id}> you can only issue one challenge at a time."
        )

      {:p2_set, %Set{}} ->
        Api.create_message(
          msg.channel_id,
          "<@#{challenged_user.username}> can only be part of one challenge at a time."
        )

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  defp handle_cmd(%{content: "$eb ping"} = msg) do
    user = UserInterface.get([{:user_id, msg.author.id}])
    set = SetInterface.get([{:player1_id, user.id}, {:status, :active}, {:preload, :default}])

    IO.inspect(set)

    Api.create_message(
      msg.channel_id,
      "<@#{user.user_id}> pong "
    )
  end

  defp handle_cmd(%{content: "$eb accept"} = msg) do
    with %User{} = user <- UserInterface.get([{:user_id, msg.author.id}]),
         %Set{} = set <-
           SetInterface.get([{:player2_id, user.id}, {:status, :open}, {:preload, :default}]) do
      {:ok, _set} = SetInterface.update(set, %{status: :accepted})

      Api.create_message(
        msg.channel_id,
        "User <@#{msg.author.id}> has accepted a challenge from <@#{set.player1.user_id}>"
      )
    else
      nil ->
        Api.create_message(
          msg.channel_id,
          "No open challenges."
        )
    end
  end

  defp handle_cmd(%{content: "$eb decline"} = msg) do
    with %User{} = user <- UserInterface.get([{:user_id, msg.author.id}]),
         %Set{} = set <-
           SetInterface.get([{:player2_id, user.id}, {:status, :open}, {:preload, :default}]) do
      {:ok, _set} = SetInterface.update(set, %{status: :accepted})

      Api.create_message(
        msg.channel_id,
        "User <@#{msg.author.id}> has declined the challenge from <@#{set.player1.user_id}>"
      )
    else
      nil ->
        Api.create_message(
          msg.channel_id,
          "No open challenges."
        )
    end
  end

  defp handle_cmd(%{content: "$eb cancel"} = msg) do
    with %User{} = user <- UserInterface.get([{:user_id, msg.author.id}]),
         %Set{} = set <-
           SetInterface.get([{:player1_id, user.id}, {:status, :active}, {:preload, :default}]) do
      {:ok, _set} = SetInterface.update(set, %{status: :canceled})

      Api.create_message(
        msg.channel_id,
        "User <@#{msg.author.id}> has canceled their challenge to <@#{set.player2.user_id}>"
      )
    else
      nil ->
        Api.create_message(
          msg.channel_id,
          "No open challenges."
        )
    end
  end

  defp handle_cmd(%{content: "$eb report" <> score_txt} = msg) do
    with %User{} = user <- UserInterface.get([{:user_id, msg.author.id}]),
         # TODO: change :accepted to :started once that logic is in place
         %Set{} = set <-
           SetInterface.get([{:player_id, user.id}, {:status, :accepted}, {:preload, :default}]),
         [_full_match, player1_score, player2_score] <-
           Regex.run(~r/([0-9]+)-([0-9]+)/, score_txt) do
      {:ok, _set} =
        SetInterface.update(set, %{
          player1_score: player1_score,
          player2_score: player2_score,
          status: :completed
        })

      Api.create_message(
        msg.channel_id,
        "<@#{set.player1.user_id}>: #{player1_score}, <@#{set.player2.user_id}>: #{player2_score}"
      )
    else
      nil ->
        Api.create_message(
          msg.channel_id,
          "Oops."
        )
    end
  end

  defp handle_cmd(%{content: "$eb register"} = msg) do
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
