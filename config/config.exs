# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :fut_stats,
  ecto_repos: [FutStats.Repo]

# Configures the endpoint
config :fut_stats, FutStatsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "srrsWs7/Lv3aBp+IE/XUJFAOADvPtgWrp3YFfDiFYMIx0pX/7UxW54Vh/GHDFTQ1",
  render_errors: [view: FutStatsWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: FutStats.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Statix configuration
config :statix,
  prefix: "#{Mix.env}",
  host: "statsd",
  port: 8125

# Instruments configuration
config :instruments,
  fast_counter_report_interval: 5000,
  probe_prefix: "probes",
  statsd_port: 8125

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
