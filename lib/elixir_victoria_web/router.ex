defmodule ElixirVictoriaWeb.Router do
  use ElixirVictoriaWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", ElixirVictoriaWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/contact", ContactController, only: [:new, :create]
  end

  if Application.get_env(:elixir_victoria, :env) === :dev do
    forward("/sent_email", Bamboo.SentEmailViewerPlug)
  end
end
