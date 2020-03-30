defmodule ElixirVictoria.Factory do
  @moduledoc "Works with ExMachina to create Ecto structs for the purposes of testing"
  use ExMachina.Ecto, repo: ElixirVictoria.Repo
  alias ElixirVictoria.Accounts.User
  alias ElixirVictoria.Group.Event
  alias Pow.Ecto.Schema.Password

  @spec user_factory :: User.t()
  def user_factory do
    %User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: password(),
      password_confirmation: password(),
      password_hash: Password.pbkdf2_hash(password())
    }
  end

  @spec event_factory :: Event.t()
  def event_factory do
    %Event{
      title: "This is a title",
      content: "This is a whole bunch of content",
      date: Date.utc_today(),
      start: "5:00PM",
      end: "7:00PM",
      location: "tyee",
      user: nil
    }
  end

  defp password, do: "10digitpassword"
end
