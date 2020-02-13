defmodule ElixirVictoria.Accounts.User do
  @moduledoc "A user, for edit permissions"
  use Ecto.Schema
  use Pow.Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          id: pos_integer | nil,
          inserted_at: DateTime.t() | nil,
          updated_at: DateTime.t() | nil,
          # Pow user fields
          email: String.t() | nil,
          password: String.t() | nil
        }

  schema "users" do
    pow_user_fields()

    timestamps()
  end

  # Don't type @spec here or dialyzer will fail, there is a duplicate spec in PowExtentions
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
  defp registration_code do
    Application.get_env(:elixir_victoria, :registration_code)
  end

  # coveralls-ignore-stop

  defp production? do
    Application.get_env(:elixir_victoria, :env) == :prod
  end
end
