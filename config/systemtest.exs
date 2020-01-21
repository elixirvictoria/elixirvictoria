use Mix.Config

# Configure your database
config :elixirvictoria, ElixirVictoria.Repo,
  username: "postgres",
  password: "postgres",
  database: "elixirvictoria_systemtest",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# We need to run a server during systemtest
config :elixirvictoria, ElixirVictoriaWeb.Endpoint,
  http: [port: 5000],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn
