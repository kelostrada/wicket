# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :wicket,
  ecto_repos: [Wicket.Repo]

# Configures the endpoint
config :wicket, Wicket.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0xdy0d4x17wV7PSozn6kdOVIFK93FVbzcJOTSV4ISLesF6XGQjph9kgcp06MCmyv",
  render_errors: [view: Wicket.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Wicket.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :wicket, :connectors,
  [:bitcoind]

config :wicket, :bitcoind,
  host: "localhost",
  port: 8332,
  user: "bitcoinrpc",
  password: "changeme",
  account: "api",
  interval: 30000,
  fetched_transactions: 100,
  webhook_url: "http://localhost:4040/api/receive"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
