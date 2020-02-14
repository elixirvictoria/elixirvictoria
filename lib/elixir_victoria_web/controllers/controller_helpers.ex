defmodule ElixirVictoriaWeb.ControllerHelpers do
  @moduledoc "Convenience helpers for controllers"
  alias ElixirVictoria.Accounts.{Policy, User}

  @spec current_user(Plug.Conn.t()) :: User.t() | nil
  def current_user(%Plug.Conn{assigns: %{current_user: current_user}}), do: current_user
  def current_user(_), do: nil

  @spec check_auth(Plug.Conn.t(), atom, struct) :: :ok | {:error, any}
  def check_auth(conn, action, resource) do
    user = current_user(conn)
    Bodyguard.permit(Policy, action, resource, user)
  end
end
