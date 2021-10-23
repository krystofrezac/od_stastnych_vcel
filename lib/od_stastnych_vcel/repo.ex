defmodule OdStastnychVcel.Repo do
  use Ecto.Repo,
    otp_app: :od_stastnych_vcel,
    adapter: Ecto.Adapters.Postgres
end
