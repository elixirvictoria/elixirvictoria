defmodule ElixirVictoriaWeb.ViewHelpers do
  @moduledoc "Common helpers for use across multiple views"
  alias ElixirVictoria.Accounts.Policy

  @doc "Returns a boolean for whether a user can use something"
  @spec permit?(Plug.Conn.t(), atom, any) :: boolean
  def permit?(%{assigns: assigns}, action, resource) do
    user = assigns[:current_user]
    Bodyguard.permit?(Policy, action, resource, user)
  end
end
