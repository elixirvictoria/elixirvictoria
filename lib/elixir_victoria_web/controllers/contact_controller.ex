defmodule ElixirVictoriaWeb.ContactController do
  use ElixirVictoriaWeb, :controller
  alias ElixirVictoria.Email
  alias ElixirVictoria.Email.{Contact, Content}

  @spec new(%Plug.Conn{}, map) :: %Plug.Conn{}
  def new(conn, _params) do
    changeset = Contact.changeset(%Content{}, %{})

    conn
    |> render("new.html", changeset: changeset)
  end

  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"message" => message_params} = params) do
    with {:ok, _response} <- verify(params),
         {:ok, message} <- Email.contact_message(message_params) do
      Email.send(message)

      conn
      |> put_flash(:info, "Your message has been sent!")
      |> redirect(to: Routes.page_path(conn, :index))
    else
      # Failed changeset validation
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Your message could not be created")
        |> render("new.html", changeset: changeset)

      # Failed recaptcha
      {:error, _} ->
        conn
        |> put_flash(:error, "Your message could not be sent due to Recaptcha failure")
        |> redirect(to: Routes.contact_path(conn, :new))
    end
  end

  # coveralls-ignore-start
  defp verify(params) do
    case Application.get_env(:elixir_victoria, :env) do
      :prod -> Recaptcha.verify(params["g-recaptcha-response"])
      _ -> {:ok, "We only use Recaptcha in production"}
    end
  end

  # coveralls-ignore-stop
end
