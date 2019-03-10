defmodule GooberBot.Event.EventMutation do
  @moduledoc "Mutations whose primary subject is an Event"

  alias GooberBot.{Repo, Event}

  def create(params) do
    %Event{}
    |> Event.changeset(params)
    |> Repo.insert()
  end

  def update(event, params) do
    event
    |> Event.changeset(params)
    |> Repo.update()
  end
end
