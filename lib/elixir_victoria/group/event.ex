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

  @type zoom_detail :: :link | :meeting_id | :password | :find_local_number

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

  @zoom_details %{
    link: "https://us02web.zoom.us/j/85812148217?pwd=UkhYd2xSSFpyMTNXcHlSak1aTVRxdz09",
    meeting_id: "858 1214 8217",
    password: "55555",
    find_local_number: "https://us02web.zoom.us/u/kcLVowqzbo"
  }

  @locations %{
    "tyee" => %{
      title: "Tyee Housing Co-op",
      address: "Tyee Housing Co-op Community Room, Unit 1 - 103 Wilson St, Victoria",
      address_html: "Tyee Housing Co-op Community Room, Unit 1 - 103 Wilson St, Victoria"
    },
    "remote" => %{
      title: "Zoom Meeting (Remote)",
      address: "Join Zoom Meeting: " <> @zoom_details.link
    }
  }

  @spec zoom_details(zoom_detail) :: String.t()
  def zoom_details(key) do
    Map.fetch!(@zoom_details, key)
  end

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
