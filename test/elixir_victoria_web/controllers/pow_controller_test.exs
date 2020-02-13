defmodule ElixirVictoriaWeb.PowControllerTest do
  use ElixirVictoriaWeb.ConnCase
  alias ElixirVictoria.Accounts.User
  alias ElixirVictoria.Repo

  describe "Registration" do
    test "Can get new registration page", %{conn: conn} do
      conn = get(conn, Routes.pow_registration_path(conn, :new))
      assert html_response(conn, 200) =~ "Register"
    end

    test "Cannot create a user without the required code", %{conn: conn} do
      user_params = %{
        email: "test@test.com",
        password: "password123",
        password_confirmation: "password123",
        registration_code: "badcode"
      }

      conn = post(conn, Routes.pow_registration_path(conn, :create), user: user_params)
      assert html_response(conn, 200) =~ "Sign in"

      # No user created
      User
      |> Repo.all()
      |> Enum.empty?()
      |> assert
    end

    test "Can create a user with the required code", %{conn: conn} do
      user_params = %{
        email: "test@test.com",
        password: "password123",
        password_confirmation: "password123",
        registration_code: "code"
      }

      conn = post(conn, Routes.pow_registration_path(conn, :create), user: user_params)
      assert redirected_to(conn) == Routes.page_path(conn, :index)

      user_count = User |> Repo.all() |> Enum.count()
      assert user_count == 1
    end
  end

  describe "Authentication" do
    test "Can get Sign in page", %{conn: conn} do
      conn = get(conn, Routes.pow_session_path(conn, :new))
      assert html_response(conn, 200) =~ "Sign in"
    end
  end
end
