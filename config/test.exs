use Mix.Config

# Configure your database
config :elixir_victoria, ElixirVictoria.Repo,
  username: "postgres",
  password: "postgres",
  database: "elixirvictoria_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :elixir_victoria, ElixirVictoriaWeb.Endpoint,
  http: [port: 4002],
  server: false

config :elixir_victoria, env: :test

# Print only warnings and errors during test
config :logger, level: :warn

config :elixir_victoria, ElixirVictoria.Email, adapter: Bamboo.TestAdapter
