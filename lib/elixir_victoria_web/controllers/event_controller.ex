defmodule ElixirVictoriaWeb.EventController do
  use ElixirVictoriaWeb, :controller

  alias ElixirVictoria.Group
  alias ElixirVictoria.Group.Event

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    upcoming_events = Group.upcoming_events()
    past_events = Group.past_events()

    with :ok <- check_auth(conn, :index, %Event{}) do
      render(conn, "index.html", upcoming_events: upcoming_events, past_events: past_events)
    end
  end

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    user = current_user(conn)

    with :ok <- check_auth(conn, :new, %Event{}) do
      changeset = Group.change_event(%Event{}, user)
      render(conn, "new.html", changeset: changeset)
    end
  end

  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"event" => event_params}) do
    user = current_user(conn)

    with :ok <- check_auth(conn, :create, %Event{}) do
      case Group.create_event(event_params, user) do
        {:ok, event} ->
          conn
          |> put_flash(:info, "Event created successfully.")
          |> redirect(to: Routes.event_path(conn, :show, event))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    event = Group.get_event!(id)

    with :ok <- check_auth(conn, :show, event) do
      render(conn, "show.html", event: event)
    end
  end

  @spec edit(Plug.Conn.t(), map) :: Plug.Conn.t()
  def edit(conn, %{"id" => id}) do
    event = Group.get_event!(id)
    user = current_user(conn)

    with :ok <- check_auth(conn, :edit, event) do
      changeset = Group.change_event(event, user)
      render(conn, "edit.html", event: event, changeset: changeset)
    end
  end

  @spec update(Plug.Conn.t(), map) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Group.get_event!(id)
    user = current_user(conn)

    with :ok <- check_auth(conn, :update, event) do
      case Group.update_event(event, event_params, user) do
        {:ok, event} ->
          conn
          |> put_flash(:info, "Event updated successfully.")
          |> redirect(to: Routes.event_path(conn, :show, event))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", event: event, changeset: changeset)
      end
    end
  end

  @spec delete(Plug.Conn.t(), map) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    event = Group.get_event!(id)

    with :ok <- check_auth(conn, :delete, event) do
      {:ok, _event} = Group.delete_event(event)

      conn
      |> put_flash(:info, "Event deleted successfully.")
      |> redirect(to: Routes.event_path(conn, :index))
    end
  end
end
