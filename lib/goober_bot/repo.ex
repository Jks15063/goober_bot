defmodule GooberBot.Repo do
  use Ecto.Repo,
    otp_app: :goober_bot,
    adapter: Ecto.Adapters.Postgres
end
