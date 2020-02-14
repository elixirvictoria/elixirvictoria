defmodule ElixirVictoria.GroupTest do
  use ElixirVictoria.DataCase

  alias ElixirVictoria.Group

  describe "events" do
    alias ElixirVictoria.Group.Event

    test "list_events/0 returns all events" do
      event = insert(:event)
      assert_comparable(Group.list_events(), [event])
    end

    test "get_event!/1 returns the event with given id" do
      event = insert(:event)
      new_event = Group.get_event!(event.id)

      assert_comparable(event, new_event)
    end

    test "create_event/1 with valid data creates a event" do
      user = insert(:user)
      event_params = params_for(:event, user_id: user.id)
      assert {:ok, %Event{} = event} = Group.create_event(event_params, user)
      assert_comparable(event_params, event)
    end

    test "create_event/1 with invalid data returns error changeset" do
      user = insert(:user)
      event_params = params_for(:event, user_id: user.id, title: "")
      assert {:error, %Ecto.Changeset{}} = Group.create_event(event_params, user)
    end

    test "update_event/2 with valid data updates the event" do
      user = insert(:user)
      event = insert(:event)
      event_params = params_for(:event, user_id: user.id, title: "Another title")
      assert {:ok, %Event{} = event} = Group.update_event(event, event_params, user)
      assert_comparable(event, event_params)
    end

    test "update_event/2 with invalid data returns error changeset" do
      user = insert(:user)
      event = insert(:event)
      event_params = params_for(:event, user_id: user.id, content: "")
      assert {:error, %Ecto.Changeset{}} = Group.update_event(event, event_params, user)
      assert_comparable(event, Group.get_event!(event.id))
    end

    test "delete_event/1 deletes the event" do
      event = insert(:event)
      assert {:ok, %Event{}} = Group.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Group.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = insert(:event)
      user = insert(:user)
      assert %Ecto.Changeset{} = Group.change_event(event, user)
    end
  end
end
