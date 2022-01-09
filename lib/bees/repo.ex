defmodule Bees.Repo do
  use Ecto.Repo,
    otp_app: :bees,
    adapter: Ecto.Adapters.Postgres
end
