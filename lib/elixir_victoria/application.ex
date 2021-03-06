defmodule ElixirVictoria.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @spec start(any, any) :: {:error, any} | {:ok, pid}
  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      ElixirVictoria.Repo,
      # Start the endpoint when the application starts
      ElixirVictoriaWeb.Endpoint,
      Pow.Store.Backend.MnesiaCache,
      {Phoenix.PubSub, [name: ElixirVictoria.PubSub, adapter: Phoenix.PubSub.PG2]}
      # Starts a worker by calling: ElixirVictoria.Worker.start_link(arg)
      # {ElixirVictoria.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirVictoria.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @spec config_change(any, any, any) :: :ok
  def config_change(changed, _new, removed) do
    ElixirVictoriaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
