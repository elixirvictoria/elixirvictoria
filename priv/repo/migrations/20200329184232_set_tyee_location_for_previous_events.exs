defmodule ElixirVictoria.Repo.Migrations.SetTyeeLocationForPreviousEvents do
  use Ecto.Migration
  alias ElixirVictoria.Accounts.User
  alias ElixirVictoria.Repo
  alias ElixirVictoria.Group.Event

  def change do
    Event
    |> Repo.all()
    |> Enum.each(&set_location/1)
  end

  defp set_location(event) do
    user = Repo.get!(User, 1)

    event
    |> Event.changeset(%{location: "tyee"}, user)
    |> Repo.update!()
  end
end
