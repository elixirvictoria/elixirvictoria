defmodule ElixirVictoriaWeb.FallbackController do
  use ElixirVictoriaWeb, :controller

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:forbidden)
    |> put_view(ElixirVictoriaWeb.ErrorView)
    |> render(:"403")
  end
end
