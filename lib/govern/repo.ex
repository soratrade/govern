defmodule Govern.Repo do
  use Ecto.Repo,
    otp_app: :govern,
    adapter: Ecto.Adapters.Postgres
end
