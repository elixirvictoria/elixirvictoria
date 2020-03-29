defmodule ElixirVictoria.Group.Event do
  @moduledoc "A real live event such as a meetup or training session"
  use Ecto.Schema
  import Ecto.Changeset
  alias ElixirVictoria.Accounts.User
  alias ElixirVictoria.Validate

  @type t :: %__MODULE__{
          id: pos_integer | nil,
          title: String.t() | nil,
          content: String.t() | nil,
          date: Date.t() | nil,
          start: String.t() | nil,
          end: String.t() | nil,
          inserted_at: DateTime.t() | nil,
          updated_at: DateTime.t() | nil,
          user: User.t() | Ecto.Association.NotLoaded.t() | nil
        }

  schema "events" do
    field :title, :string
    field :content, :string
    field :date, :date
    field :start, :string
    field :end, :string
    field :location, :string
    belongs_to :user, User

    timestamps()
  end

  # key is the title, value is the template.
  @locations %{
    "Tyee Housing" => "tyee",
    "Remote" => "remote"
  }

  def locations, do: @locations

  @available_attributes [:date, :start, :end, :title, :content, :location]
  @required_attributes @available_attributes ++ [:user_id]

  @doc false
  @spec changeset(t(), map, User.t()) :: Ecto.Changeset.t()
  def changeset(event, attrs, user) do
    event
    |> cast(attrs, @available_attributes)
    |> put_change(:user_id, user.id)
    |> validate_required(@required_attributes)
    |> validate_inclusion(:location, Map.values(@locations))
    |> Validate.time_format(:start)
    |> Validate.time_format(:end)
  end
end
