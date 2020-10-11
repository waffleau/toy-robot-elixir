defmodule ToyRobot.Command do
  defstruct [:name, :args]

  def from_string(string) do
    string
    |> String.upcase()
    |> String.split("\n")
    |> Enum.map(&parse_command_string/1)
    |> Enum.reject(&is_nil/1)
  end

  defp parse_command_string("LEFT"), do: %__MODULE__{name: :left}
  defp parse_command_string("MOVE"), do: %__MODULE__{name: :move}
  defp parse_command_string("REPORT"), do: %__MODULE__{name: :report}
  defp parse_command_string("RIGHT"), do: %__MODULE__{name: :right}

  defp parse_command_string("PLACE " <> args) do
    with [x_str, y_str, dir_str] <- String.split(args, ","),
         {:ok, x} <- string_to_int(x_str),
         {:ok, y} <- string_to_int(y_str),
         {:ok, direction} <- parse_direction(dir_str) do
      %__MODULE__{name: :place, args: %{x: x, y: y, direction: direction}}
    else
      _error -> nil
    end
  end

  defp parse_command_string(_string), do: nil

  defp parse_direction("NORTH"), do: {:ok, :north}
  defp parse_direction("SOUTH"), do: {:ok, :south}
  defp parse_direction("EAST"), do: {:ok, :east}
  defp parse_direction("WEST"), do: {:ok, :west}
  defp parse_direction(direction), do: {:invalid_direction, direction}

  defp string_to_int(str) do
    case Integer.parse(str) do
      {int, _rem} -> {:ok, int}
      :error -> {:invalid_integer, str}
    end
  end
end
