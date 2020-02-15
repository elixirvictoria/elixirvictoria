defmodule ElixirVictoria.Accounts.Policy do
  @moduledoc "Authorization policies for users"
  alias ElixirVictoria.Accounts.User
  alias ElixirVictoria.Group.Event

  @spec authorize(atom, struct, struct | nil) :: boolean
  def authorize(action, %Event{} = _event, _)
      when action in [:index, :show],
      do: true

  def authorize(action, %Event{} = _event, %User{} = _user)
      when action in [:new, :create, :edit, :update, :delete],
      do: true

  def authorize(_, _, _), do: false
end
