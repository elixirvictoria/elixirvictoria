defmodule ElixirVictoriaWeb.PageController do
  use ElixirVictoriaWeb, :controller
  alias ElixirVictoria.Group

  @spec index(Plug.Conn.t(), map) :: Plug.Conn.t()
  def index(conn, _params), do: render(conn, "index.html", next_event: Group.next_event())

  @spec about(Plug.Conn.t(), map) :: Plug.Conn.t()
  def about(conn, _params), do: render(conn, "about.html")
end
