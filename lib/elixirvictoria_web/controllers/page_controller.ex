defmodule ElixirVictoriaWeb.PageController do
  use ElixirVictoriaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
