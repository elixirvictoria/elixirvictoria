defmodule ElixirVictoriaWeb.EventView do
  use ElixirVictoriaWeb, :view
  alias ElixirVictoria.Group
  alias ElixirVictoria.Group.Event

  @spec locations_for_select :: [{String.t(), String.t()}]
  defdelegate locations_for_select, to: Event

  @spec location_values :: [String.t()]
  defdelegate location_values, to: Event

  @spec address_for_location(String.t()) :: String.t()
  defdelegate address_for_location(location), to: Event

  @spec html_address_for_location(String.t()) :: {:ok, iolist} | String.t()
  defdelegate html_address_for_location(location), to: Event

  @spec nice(Date.t()) :: binary
  def nice(%Date{} = date) do
    weekday = get_weekday(date)
    month = get_month(date)

    "#{weekday} #{date.day} #{month} #{date.year}"
  end

  @weekdays ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

  defp get_weekday(date) do
    num =
      date
      |> Date.day_of_week()
      |> Kernel.-(1)

    Enum.at(@weekdays, num)
  end

  @months [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ]

  defp get_month(date) do
    num =
      date
      |> Map.get(:month)
      |> Kernel.-(1)

    Enum.at(@months, num)
  end

  @doc "Makes an `Add to Google Calendar` button"
  @spec add_to_google_calendar(Event.t()) :: {:safe, iolist}
  def add_to_google_calendar(event) do
    title = plusify("Elixir Victoria #{event.title}")
    location = event.location |> Event.address_for_location() |> plusify()
    start_time = Group.to_zulu_time(event, :start)
    end_time = Group.to_zulu_time(event, :end)

    ~e"""
    <a href="https://www.google.com/calendar/render?action=TEMPLATE
    &text=<%= title %>
    &dates=<%= start_time %>/<%= end_time %>
    &details=For+details,+link+here:+https://www.elixirvictoria.com/events/<%= event.id %>
    &location=<%= location %>
    &sf=true&output=xml"
    target="_blank"
    class="btn btn-sm btn-primary"> <%= icon("calendar", class: "small-icon") %> Add to Google Calendar </a>
    """
  end

  @spec plusify(binary) :: binary
  defp plusify(sentence) do
    sentence
    |> String.replace(" ", "+")
    |> String.replace("#", "")
  end

  @doc "Returns true if event is in the future"
  @spec upcoming?(Event.t()) :: boolean
  def upcoming?(event) do
    Date.compare(Date.utc_today(), event.date) == :lt
  end
end
