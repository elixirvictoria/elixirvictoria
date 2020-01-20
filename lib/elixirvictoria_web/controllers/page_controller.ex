defmodule ElixirvictoriaWeb.PageController do
  use ElixirvictoriaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
