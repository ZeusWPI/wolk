import Config

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.

config :ueberauth, Ueberauth.Strategy.Zauth.OAuth,
  client_id: System.get_env("ZAUTH_CLIENT_ID"),
  client_secret: System.get_env("ZAUTH_CLIENT_SECRET")

config :waffle,
  storage: Waffle.Storage.S3,
  # or {:system, "AWS_S3_BUCKET"}
  bucket: "custom_bucket",
  # or {:system, "ASSET_HOST"}
  asset_host: "http://static.example.com"

config :ex_aws,
  json_codec: Jason

# any configurations provided by https://github.com/ex-aws/ex_aws
