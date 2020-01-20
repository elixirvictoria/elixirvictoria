# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixirvictoria,
  ecto_repos: [Elixirvictoria.Repo]

# Configures the endpoint
config :elixirvictoria, ElixirvictoriaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GDT7gw7WrmFfyw5US4DDklvKP3EAT6p1sxp7q2mdxpymPap3+TD4y7xE7ar2Sw51",
  render_errors: [view: ElixirvictoriaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Elixirvictoria.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
