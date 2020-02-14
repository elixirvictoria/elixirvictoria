defmodule ElixirVictoria.Group.Event do
  @moduledoc "A real live event such as a meetup or training session"
  use Ecto.Schema
  import Ecto.Changeset
  alias ElixirVictoria.Accounts.User

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
    belongs_to :user, User

    timestamps()
  end

  @required_attributes [:date, :start, :end, :title, :content, :user_id]
  @available_attributes [:date, :start, :end, :title, :content]

  @doc false
  @spec changeset(t(), map, User.t()) :: Ecto.Changeset.t()
  def changeset(event, attrs, user) do
    event
    |> cast(attrs, @available_attributes)
    |> put_change(:user_id, user.id)
    |> validate_required(@required_attributes)
  end
end
