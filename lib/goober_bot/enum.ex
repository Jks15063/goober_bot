defmodule GooberBot.Enum do
  @moduledoc """
  Defines enum fields.
  """
  import EctoEnum

  defenum(EventStatus, :set_status, [:open, :accepted, :started, :completed, :canceled])
  defenum(SkillLevel, :skill_level, [:beginner, :intermidiate, :advanced])
  defenum(EventOutcome, :event_outcome, [:win, :lose, :draw])
end
