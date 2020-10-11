defmodule ToyRobot.BoardTest do
  use ExUnit.Case

  alias ToyRobot.Board

  describe "valid_location?/3" do
    setup do
      height = :rand.uniform(10)
      width = :rand.uniform(10)
      board = %Board{height: height, width: width}

      [board: board]
    end

    test "within bounds", %{board: board} do
      assert Board.valid_location?(board, 0, 0)
      assert Board.valid_location?(board, board.width - 1, 0)
      assert Board.valid_location?(board, 0, board.height - 1)
      assert Board.valid_location?(board, board.width - 1, board.height - 1)
    end

    test "out of bounds", %{board: board} do
      refute Board.valid_location?(board, -1, 0)
      refute Board.valid_location?(board, 0, -1)
      refute Board.valid_location?(board, -1, -1)
      refute Board.valid_location?(board, board.width, 0)
      refute Board.valid_location?(board, 0, board.height)
      refute Board.valid_location?(board, board.width, board.height)
    end
  end
end
