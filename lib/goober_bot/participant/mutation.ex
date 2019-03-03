defmodule GooberBot.Participant.ParticipantMutation do
  @moduledoc "Mutations whose primary subject is a `Participant`"

  alias GooberBot.{Repo, Participant}

  def create(params) do
    %Participant{}
    |> Participant.changeset(params)
    |> Repo.insert()
  end

  def update(participant, params) do
    participant
    |> Participant.changeset(params)
    |> Repo.update()
  end
end
