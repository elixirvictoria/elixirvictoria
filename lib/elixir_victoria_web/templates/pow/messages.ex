defmodule ElixirVictoriaWeb.Pow.Messages do
  @moduledoc "Messaging for Pow, appears in flash messages"
  use Pow.Phoenix.Messages
  import ElixirVictoriaWeb.Gettext

  def user_not_authenticated(_conn), do: gettext("You need to be logged in to access this page")
  def user_already_authenticated(_conn), do: gettext("You are already signed in")
  def signed_out(_conn), do: gettext("Signed out successfully.")
  def signed_in(_conn), do: gettext("Signed in successfully.")
  def invalid_credentials(_conn), do: gettext("Your credentials are invalid")
  def user_has_been_created(_conn), do: gettext("New account created successfully")
  def user_has_been_updated(_conn), do: gettext("Account updated successfully")
  def user_has_been_deleted(_conn), do: gettext("Account deleted successfully.")
  def user_could_not_be_deleted(_conn), do: gettext("Your account could not be deleted.")
end
