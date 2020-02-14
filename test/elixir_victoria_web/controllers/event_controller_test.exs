defmodule ElixirVictoriaWeb.EventControllerTest do
  use ElixirVictoriaWeb.ConnCase

  describe "index" do
    test "lists all events when not logged in", %{conn: conn} do
      conn = get(conn, Routes.event_path(conn, :index))
      assert html_response(conn, 200) =~ "Events"
    end
  end

  describe "new event" do
    test "renders form when logged in", %{conn: conn} do
      user = insert(:user)
      conn = log_in(conn, user)
      conn = get(conn, Routes.event_path(conn, :new))
      assert html_response(conn, 200) =~ "New Event"
    end
  end

  describe "create event" do
    test "redirects to show when data is valid and logged in", %{conn: conn} do
      user = insert(:user)
      conn = log_in(conn, user)
      event_params = params_for(:event)
      conn = post(conn, Routes.event_path(conn, :create), event: event_params)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.event_path(conn, :show, id)

      conn = get(conn, Routes.event_path(conn, :show, id))
      assert html_response(conn, 200) =~ event_params.title
    end

    test "renders errors when data is invalid and logged in", %{conn: conn} do
      user = insert(:user)
      conn = log_in(conn, user)
      event_params = params_for(:event, title: "")
      conn = post(conn, Routes.event_path(conn, :create), event: event_params)
      assert html_response(conn, 200) =~ "New Event"
    end
  end

  describe "edit event" do
    test "renders form for editing chosen event when logged in", %{conn: conn} do
      user = insert(:user)
      event = insert(:event)
      conn = log_in(conn, user)
      conn = get(conn, Routes.event_path(conn, :edit, event))
      assert html_response(conn, 200) =~ "Edit Event"
    end
  end

  describe "update event" do
    test "redirects when data is valid and user logged in", %{conn: conn} do
      user = insert(:user)
      conn = log_in(conn, user)
      event = insert(:event, user: user)

      event_params = params_for(:event, title: "something else")

      conn = put(conn, Routes.event_path(conn, :update, event), event: event_params)
      assert redirected_to(conn) == Routes.event_path(conn, :show, event)

      conn = get(conn, Routes.event_path(conn, :show, event))
      assert html_response(conn, 200) =~ "something else"
    end

    test "renders errors when data is invalid and user is logged in", %{conn: conn} do
      user = insert(:user)
      conn = log_in(conn, user)
      event = insert(:event, user: user)
      event_params = params_for(:event, content: "")
      conn = put(conn, Routes.event_path(conn, :update, event), event: event_params)
      assert html_response(conn, 200) =~ "Edit Event"
    end
  end

  describe "delete event" do
    test "deletes chosen event when logged in", %{conn: conn} do
      user = insert(:user)
      event = insert(:event)
      conn = log_in(conn, user)
      conn = delete(conn, Routes.event_path(conn, :delete, event))
      assert redirected_to(conn) == Routes.event_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.event_path(conn, :show, event))
      end
    end
  end
end
