defmodule GooberBot.Enum do
  @moduledoc """
  Defines enum fields.
  """
  import EctoEnum

  defenum(SetStatus, :set_status, [:open, :accepted, :started, :completed, :canceled])
end
