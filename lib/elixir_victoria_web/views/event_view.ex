defmodule ElixirVictoriaWeb.EventView do
  use ElixirVictoriaWeb, :view

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
end
