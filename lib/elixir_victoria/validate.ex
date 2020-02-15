defmodule ElixirVictoria.Validate do
  @moduledoc "Changeset validations that would otherwise clutter up schemas"
  import Ecto.Changeset

  @spec time_format(Ecto.Changeset.t(), atom) :: Ecto.Changeset.t()
  def time_format(changeset, field) do
    regex = ~r/(?<hrs>\d{1,2}):(?<min>\d{2})(?<suf>\w{2})/

    with {_, time} <- fetch_field(changeset, field),
         :ok <- validate_not_nil(time),
         true <- Regex.match?(regex, time),
         %{"hrs" => hrs, "min" => min, "suf" => suf} <- Regex.named_captures(regex, time),
         :ok <- validate_hours(hrs),
         :ok <- validate_minutes(min),
         :ok <- validate_suffix(suf) do
      changeset
    else
      {:error, message} -> add_error(changeset, field, message)
      _ -> add_error(changeset, field, "Must be a valid time format such as 8:37PM")
    end
  end

  # Need to make sure not nil or Regex.match? fails hard.
  defp validate_not_nil(nil), do: :error
  defp validate_not_nil(_), do: :ok

  @valid_hours Enum.map(1..12, &Integer.to_string/1)

  defp validate_hours(hours) when hours in @valid_hours, do: :ok
  defp validate_hours(hours), do: {:error, "Hours must be between 1 and 12, got: #{hours}"}

  @valid_minutes Enum.map(0..9, fn int -> "0" <> Integer.to_string(int) end) ++
                   Enum.map(10..59, &Integer.to_string/1)

  defp validate_minutes(minutes) when minutes in @valid_minutes, do: :ok
  defp validate_minutes(minutes), do: {:error, "Hours must be between 00 and 59, got: #{minutes}"}

  @valid_suffixes ["AM", "PM"]

  defp validate_suffix(suffix) when suffix in @valid_suffixes, do: :ok
  defp validate_suffix(suffix), do: {:error, "Suffixes must be AM or PM, got: #{suffix}"}
end
