defmodule ElixirVictoria.Group.Event do
  @moduledoc "A real live event such as a meetup or training session"
  use Ecto.Schema
  import Ecto.Changeset
  import Phoenix.HTML
  import Phoenix.HTML.Link
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

  @locations %{
    "tyee" => %{
      title: "Tyee Housing Co-op",
      address: "Tyee Housing Co-op Community Room, Unit 1 - 103 Wilson St, Victoria",
      address_html: "Tyee Housing Co-op Community Room, Unit 1 - 103 Wilson St, Victoria"
    },
    "remote" => %{
      title: "Zoom Meeting (Remote)",
      address: "Join Zoom Meeting: https://us04web.zoom.us/j/135902266",
      address_html:
        ~e"Join Zoom Meeting: <%= link \"https://us04web.zoom.us/j/135902266\", to: \"https://us04web.zoom.us/j/135902266\" %>"
    }
  }

  @spec locations_for_select :: [{String.t(), String.t()}]
  def locations_for_select do
    Enum.map(@locations, fn {k, v} -> {v.title, k} end)
  end

  @spec location_values :: [String.t()]
  def location_values, do: Enum.map(@locations, fn {k, _v} -> k end)

  @spec address_for_location(String.t()) :: String.t()
  def address_for_location(location) do
    get_in(@locations, [location, :address])
  end

  @spec html_address_for_location(String.t()) :: {:ok, iolist} | String.t()
  def html_address_for_location(location) do
    get_in(@locations, [location, :address_html])
  end

  @available_attributes [:date, :start, :end, :title, :content, :location]
  @required_attributes @available_attributes ++ [:user_id]

  @doc false
  @spec changeset(t(), map, User.t()) :: Ecto.Changeset.t()
  def changeset(event, attrs, user) do
    event
    |> cast(attrs, @available_attributes)
    |> put_change(:user_id, user.id)
    |> validate_required(@required_attributes)
    |> validate_inclusion(:location, location_values())
    |> Validate.time_format(:start)
    |> Validate.time_format(:end)
  end
end
