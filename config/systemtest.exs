use Mix.Config

# Configure your database
config :elixir_victoria, ElixirVictoria.Repo,
  username: "postgres",
  password: "postgres",
  database: "elixirvictoria_systemtest",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# We need to run a server during systemtest
config :elixir_victoria, ElixirVictoriaWeb.Endpoint,
  http: [port: 5000],
  server: true

config :elixir_victoria, env: :systemtest
# Print only warnings and errors during test
config :logger, level: :warn
