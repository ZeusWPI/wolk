import Config

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.

config :ueberauth, Ueberauth.Strategy.Zauth.OAuth,
  client_id: System.get_env("ZAUTH_CLIENT_ID"),
  client_secret: System.get_env("ZAUTH_CLIENT_SECRET")
