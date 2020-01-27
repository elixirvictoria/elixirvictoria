defmodule ElixirVictoriaWeb.Router do
  use ElixirVictoriaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", ElixirVictoriaWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/contact", ContactController, only: [:new, :create]
  end

  if Mix.env() == :dev, do: forward("/sent_emails", Bamboo.SentEmailViewerPlug)
end
