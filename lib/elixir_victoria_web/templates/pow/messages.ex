defmodule ElixirVictoriaWeb.Pow.Messages do
  @moduledoc "Messaging for Pow, appears in flash messages"
  use Pow.Phoenix.Messages
  import ElixirVictoriaWeb.Gettext

  @spec user_not_authenticated(Plug.Conn.t()) :: binary
  def user_not_authenticated(_conn), do: gettext("You need to be logged in to access this page")

  @spec user_already_authenticated(Plug.Conn.t()) :: binary
  def user_already_authenticated(_conn), do: gettext("You are already signed in")

  @spec signed_out(Plug.Conn.t()) :: binary
  def signed_out(_conn), do: gettext("Signed out successfully.")

  @spec signed_in(Plug.Conn.t()) :: binary
  def signed_in(_conn), do: gettext("Signed in successfully.")

  @spec invalid_credentials(Plug.Conn.t()) :: binary
  def invalid_credentials(_conn), do: gettext("Your credentials are invalid")

  @spec user_has_been_created(Plug.Conn.t()) :: binary
  def user_has_been_created(_conn), do: gettext("New account created successfully")

  @spec user_has_been_updated(Plug.Conn.t()) :: binary
  def user_has_been_updated(_conn), do: gettext("Account updated successfully")

  @spec user_has_been_deleted(Plug.Conn.t()) :: binary
  def user_has_been_deleted(_conn), do: gettext("Account deleted successfully.")

  @spec user_could_not_be_deleted(Plug.Conn.t()) :: binary
  def user_could_not_be_deleted(_conn), do: gettext("Your account could not be deleted.")
end
