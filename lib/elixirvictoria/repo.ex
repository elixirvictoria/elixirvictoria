defmodule ElixirVictoria.Repo do
  use Ecto.Repo,
    otp_app: :elixirvictoria,
    adapter: Ecto.Adapters.Postgres
end
