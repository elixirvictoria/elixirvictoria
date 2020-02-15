defmodule ElixirVictoria.Group do
  @moduledoc "The Group context. Centered around organizing groups of people out in the real world"

  import Ecto.Query, warn: false
  alias ElixirVictoria.Repo

  alias ElixirVictoria.Accounts.User
  alias ElixirVictoria.Group.Event

  @type response_tuples :: {:ok, Event.t()} | {:error, Ecto.Changeset.t()}
  @type denied :: {:error, :unauthorized}

  @spec list_events :: [Event.t()]
  def list_events do
    Repo.all(from e in Event, order_by: e.date)
  end

  @spec upcoming_events :: [Event.t()]
  def upcoming_events do
    today = Date.utc_today()
    order_by = [asc: :date]
    Repo.all(from e in Event, where: e.date >= ^today, order_by: ^order_by)
  end

  @spec past_events :: [Event.t()]
  def past_events do
    today = Date.utc_today()
    order_by = [desc: :date]
    Repo.all(from e in Event, where: e.date < ^today, order_by: ^order_by)
  end

  @spec next_event :: Event.t() | nil
  def next_event do
    case upcoming_events() do
      [] -> nil
      events -> List.first(events)
    end
  end

  @spec get_event!(pos_integer) :: Event.t() | Ecto.NoResultsError
  def get_event!(id), do: Repo.get!(Event, id)

  @spec create_event(any, nil | ElixirVictoria.Accounts.User.t()) :: denied | response_tuples
  def create_event(_, nil) do
    {:error, :unauthorized}
  end

  def create_event(attrs, user) do
    %Event{}
    |> Event.changeset(attrs, user)
    |> Repo.insert()
  end

  @spec update_event(any, any, nil | User.t()) :: response_tuples
  def update_event(_, _, nil) do
    {:error, :unauthorized}
  end

  def update_event(%Event{} = event, attrs, user) do
    event
    |> Event.changeset(attrs, user)
    |> Repo.update()
  end

  @spec delete_event(Event.t()) :: {:ok, Event.t()}
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @spec change_event(any, nil | User.t()) ::
          {:error, :unauthorized} | Ecto.Changeset.t()
  def change_event(_, nil) do
    {:error, :unauthorized}
  end

  def change_event(%Event{} = event, user) do
    Event.changeset(event, %{}, user)
  end
end
