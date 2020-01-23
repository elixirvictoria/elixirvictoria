defmodule ElixirVictoriaWeb.PageController do
  use ElixirVictoriaWeb, :controller

  def index(conn, _params), do: render(conn, "index.html")
  def location(conn, _params), do: render(conn, "location.html")
end
