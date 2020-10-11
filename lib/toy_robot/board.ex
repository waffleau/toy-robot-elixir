defmodule ToyRobot.Board do
  defstruct [:height, :width]

  def valid_location?(board, x, y) do
    x >= 0 and x < board.width and y >= 0 and y < board.height
  end
end
