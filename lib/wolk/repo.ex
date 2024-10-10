defmodule Wolk.Repo do
  use Ecto.Repo,
    otp_app: :wolk,
    adapter: Ecto.Adapters.Postgres
end
