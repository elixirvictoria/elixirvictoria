defmodule ElixirVictoria.Repo do
  use Ecto.Repo,
    otp_app: :elixir_victoria,
    adapter: Ecto.Adapters.Postgres
end
