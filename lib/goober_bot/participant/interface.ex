defmodule GooberBot.Participant.ParticipantInterface do
  @moduledoc """
  Public-facing functions for working with a Participant struct
  """

  alias GooberBot.Participant.{ParticipantMutation, ParticipantQuery}

  defdelegate get(criteria), to: ParticipantQuery

  defdelegate create(params), to: ParticipantMutation
  defdelegate update(participant, params), to: ParticipantMutation
end
