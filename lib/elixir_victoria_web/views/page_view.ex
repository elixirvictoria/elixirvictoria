defmodule ElixirVictoriaWeb.PageView do
  use ElixirVictoriaWeb, :view
  alias ElixirVictoriaWeb.EventView

  defdelegate location_values, to: EventView
end
