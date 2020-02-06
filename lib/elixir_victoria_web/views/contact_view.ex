defmodule ElixirVictoriaWeb.ContactView do
  use ElixirVictoriaWeb, :view

  def production? do
    case Application.get_env(:elixir_victoria, :env) do
      :prod -> true
      _ -> false
    end
  end
end
