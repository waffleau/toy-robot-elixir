defmodule ToyRobot.Robot do
  defstruct [:x, :y, :direction]

  alias ToyRobot.Board

  def left(%__MODULE__{} = robot) do
    case robot.direction do
      :north -> {:ok, %{robot | direction: :west}}
      :south -> {:ok, %{robot | direction: :east}}
      :east -> {:ok, %{robot | direction: :north}}
      :west -> {:ok, %{robot | direction: :south}}
      _else -> {:error, :invalid_left}
    end
  end

  def move(%__MODULE__{} = robot, board) do
    with {x, y} <- next_position(robot),
         true <- Board.valid_location?(board, x, y) do
      {:ok, %{robot | x: x, y: y}}
    else
      _error -> {:error, :invalid_move}
    end
  end

  def place(%__MODULE__{} = robot, board, x, y, direction) do
    case Board.valid_location?(board, x, y) do
      true -> {:ok, %{robot | x: x, y: y, direction: direction}}
      false -> {:error, :invalid_place}
    end
  end

  def report(%__MODULE__{} = robot) do
    case robot.direction do
      nil -> IO.puts("not placed")
      _else -> IO.puts("#{robot.x},#{robot.y},#{robot.direction}")
    end

    {:ok, robot}
  end

  def right(%__MODULE__{} = robot) do
    case robot.direction do
      :north -> {:ok, %{robot | direction: :east}}
      :south -> {:ok, %{robot | direction: :west}}
      :east -> {:ok, %{robot | direction: :south}}
      :west -> {:ok, %{robot | direction: :north}}
      _else -> {:error, :invalid_right}
    end
  end

  defp next_position(%__MODULE__{x: x, y: y, direction: direction}) do
    case direction do
      :north -> {x, y + 1}
      :south -> {x, y - 1}
      :east -> {x + 1, y}
      :west -> {x - 1, y}
      _else -> {:error, :invalid_direction}
    end
  end
end
