# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :goober_bot,
  ecto_repos: [GooberBot.Repo]

# Configures the endpoint
config :goober_bot, GooberBotWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ycsiy6vv6v4f57+5zD6x/Rylpr+GBRb12ZH5vl6/Plp173l4VChemnIWv0COaEL+",
  render_errors: [view: GooberBotWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GooberBot.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :nostrum,
  token: System.get_env("DISCORD_BOT_TOKEN"),
  num_shards: :auto

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
