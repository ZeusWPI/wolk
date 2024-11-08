# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :wolk,
  ecto_repos: [Wolk.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :wolk, WolkWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: WolkWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Wolk.PubSub,
  live_view: [signing_salt: "ljE6cJVJ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  base_path: "/api/auth",
  providers: [
    zauth: {Ueberauth.Strategy.Zauth, [default_scope: ""]}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
