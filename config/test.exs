import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :od_stastnych_vcel, OdStastnychVcel.Repo,
  username: "postgres",
  password: "postgres",
  database: "od_stastnych_vcel_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :od_stastnych_vcel, OdStastnychVcelWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "/Au4QC1alH/AUCLfq+2qi/htKpxDtLSg8u/dEsura1etQ8vx0XfsZjbK5xyaRgei",
  server: false

# In test we don't send emails.
config :od_stastnych_vcel, OdStastnychVcel.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
