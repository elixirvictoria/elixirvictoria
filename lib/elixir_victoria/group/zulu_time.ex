defmodule ElixirVictoria.Group.ZuluTime do
  @moduledoc "Converts the Date/Time combination into Google compatible zulu time"
  require Logger
  @time_regex ~r/(?<hrs>\d{1,2}):(?<min>\d{2})(?<suf>\w{2})/

  @doc "Builds Google API compatible Zulu time from Date and a string time"
  @spec build(Date.t(), binary) :: binary
  def build(date, time) do
    with {hrs, min} <- hours_and_minutes(time),
         {:ok, naive_datetime} <-
           NaiveDateTime.new(date.year, date.month, date.day, hrs, min, 0),
         {:ok, datetime} <- DateTime.from_naive(naive_datetime, "America/Vancouver"),
         {:ok, datetime} <- DateTime.shift_zone(datetime, "Zulu"),
         iso8601 <- DateTime.to_iso8601(datetime, :basic),
         zulutime <- String.replace(iso8601, "+0000", "Z") do
      zulutime
    else
      message ->
        Logger.warn("""
        Could not convert to Zulutime in #{inspect(__MODULE__)},
        message: #{inspect(message)}
        """)

        ""
    end
  end

  @spec hours_and_minutes(binary) :: {non_neg_integer, non_neg_integer}
  defp hours_and_minutes(time) do
    %{"hrs" => hrs, "min" => min, "suf" => suf} = Regex.named_captures(@time_regex, time)
    hours = maybe_add_12(hrs, suf)
    minutes = String.to_integer(min)

    {hours, minutes}
  end

  @spec maybe_add_12(binary, binary) :: non_neg_integer
  defp maybe_add_12(hrs, "AM"), do: String.to_integer(hrs)
  defp maybe_add_12(hrs, "PM"), do: String.to_integer(hrs) + 12
end
