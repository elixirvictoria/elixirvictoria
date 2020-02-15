defmodule ElixirVictoria.Accounts.User do
  @moduledoc "A user, for edit permissions"
  use Ecto.Schema
  use Pow.Ecto.Schema
  import Ecto.Changeset
  alias ElixirVictoria.Group.Event

  @type t :: %__MODULE__{
          id: pos_integer | nil,
          inserted_at: DateTime.t() | nil,
          updated_at: DateTime.t() | nil,
          # Pow user fields
          email: String.t() | nil,
          password: String.t() | nil,
          password_confirmation: String.t() | nil,
          events: [Event.t()] | Ecto.Association.NotLoaded.t()
        }

  schema "users" do
    pow_user_fields()
    field :password_confirmation, :string, virtual: true
    has_many :events, Event

    timestamps()
  end

  # Don't type @spec here or dialyzer will fail, there is a duplicate spec in PowExtensions
  @impl true
  def changeset(user, attrs) do
    user
    |> pow_changeset(attrs)
    |> maybe_block_registration(attrs)
  end

  @spec maybe_block_registration(Ecto.Changeset.t(), map) :: Ecto.Changeset.t()
  defp maybe_block_registration(changeset, attrs) do
    registration_code = if production?(), do: registration_code(), else: "code"
    code = attrs["registration_code"]

    cond do
      changeset.changes === %{} ->
        changeset

      code === registration_code ->
        changeset

      true ->
        add_error(
          changeset,
          :code,
          "Incorrect code for new user registration. Please contact us."
        )
    end
  end

  # coveralls-ignore-start

  @doc """
  Any pow password works in development mode
  spec already defined in pow
  """
  @impl true
  def verify_password(user, password) do
    development?() || pow_verify_password(user, password)
  end

  defp registration_code do
    Application.get_env(:elixir_victoria, :registration_code)
  end

  # coveralls-ignore-stop

  defp production? do
    Application.get_env(:elixir_victoria, :env) == :prod
  end

  defp development? do
    Application.get_env(:elixir_victoria, :env) == :dev
  end
end
