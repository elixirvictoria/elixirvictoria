defmodule ElixirVictoriaWeb.ContactControllerTest do
  @moduledoc false
  use ElixirVictoriaWeb.ConnCase, async: true
  use Bamboo.Test

  test "Can get contact form", %{conn: conn} do
    conn = get(conn, "/contact/new")
    assert html_response(conn, 200) =~ "Contact"
  end

  test "Can submit contact form", %{conn: conn} do
    message_params = %{
      from_email: "bob@marley.com",
      name: "Bob Marley",
      message: "Lets get together and feel alright"
    }

    conn = post(conn, Routes.contact_path(conn, :create), message: message_params)
    assert html_response(conn, 302)

    assert_email_delivered_with(html_body: ~r/Lets get together and feel alright/)
  end

  test "Cannot submit contact form when no email address", %{conn: conn} do
    message_params = %{
      from_email: "",
      name: "Bob Marley",
      message: "Lets get together and feel alright"
    }

    conn = post(conn, Routes.contact_path(conn, :create), message: message_params)
    assert html_response(conn, 200)

    assert_no_emails_delivered()
  end
end
