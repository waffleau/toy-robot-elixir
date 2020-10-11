defmodule ToyRobot.RobotTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ToyRobot.{Board, Robot}

  setup do
    [board: %Board{height: 5, width: 5}]
  end

  describe "left/1" do
    test "returns robot with new direction if placed" do
      robot = %Robot{x: 2, y: 2, direction: :north}
      assert {:ok, %{direction: :west}} = Robot.left(robot)

      robot = %Robot{x: 2, y: 2, direction: :south}
      assert {:ok, %{direction: :east}} = Robot.left(robot)

      robot = %Robot{x: 2, y: 2, direction: :east}
      assert {:ok, %{direction: :north}} = Robot.left(robot)

      robot = %Robot{x: 2, y: 2, direction: :west}
      assert {:ok, %{direction: :south}} = Robot.left(robot)
    end

    test "returns an error if the robot has no direction" do
      robot = %Robot{}
      assert {:error, :invalid_left} = Robot.left(robot)
    end
  end

  describe "move/2" do
    test "moves robot one unit in the faced direction", %{board: board} do
      robot = %Robot{x: 2, y: 2, direction: :north}
      assert {:ok, %{x: 2, y: 3}} = Robot.move(robot, board)

      robot = %Robot{x: 2, y: 2, direction: :south}
      assert {:ok, %{x: 2, y: 1}} = Robot.move(robot, board)

      robot = %Robot{x: 2, y: 2, direction: :east}
      assert {:ok, %{x: 3, y: 2}} = Robot.move(robot, board)

      robot = %Robot{x: 2, y: 2, direction: :west}
      assert {:ok, %{x: 1, y: 2}} = Robot.move(robot, board)
    end

    test "returns an error if the move would put the robot off the board", %{board: board} do
      robot = %Robot{x: 2, y: 4, direction: :north}
      assert {:error, :invalid_move} = Robot.move(robot, board)

      robot = %Robot{x: 2, y: 0, direction: :south}
      assert {:error, :invalid_move} = Robot.move(robot, board)

      robot = %Robot{x: 4, y: 2, direction: :east}
      assert {:error, :invalid_move} = Robot.move(robot, board)

      robot = %Robot{x: 0, y: 2, direction: :west}
      assert {:error, :invalid_move} = Robot.move(robot, board)
    end
  end

  describe "place/5" do
    test "returns a robot if position is valid", %{board: board} do
      assert {:ok, %Robot{x: 0, y: 0, direction: :north}} =
               Robot.place(%Robot{}, board, 0, 0, :north)

      assert {:ok, %Robot{x: 4, y: 4, direction: :north}} =
               Robot.place(%Robot{}, board, 4, 4, :north)
    end

    test "returns an error if position is invalid", %{board: board} do
      assert {:error, :invalid_place} = Robot.place(%Robot{}, board, -1, -1, :north)
      assert {:error, :invalid_place} = Robot.place(%Robot{}, board, -1, 0, :north)
      assert {:error, :invalid_place} = Robot.place(%Robot{}, board, 0, -1, :north)
      assert {:error, :invalid_place} = Robot.place(%Robot{}, board, 5, 5, :north)
      assert {:error, :invalid_place} = Robot.place(%Robot{}, board, 5, 0, :north)
      assert {:error, :invalid_place} = Robot.place(%Robot{}, board, 0, 5, :north)
    end
  end

  describe "report/1" do
    test "reports the robot's current position" do
      robot = %Robot{x: 1, y: 2, direction: :north}
      assert capture_io(fn -> Robot.report(robot) end) == "1,2,north\n"
    end

    test "reports not placed if robot has no direction" do
      robot = %Robot{}
      assert capture_io(fn -> Robot.report(robot) end) == "not placed\n"
    end
  end

  describe "right/1" do
    test "returns robot with new direction if placed" do
      robot = %Robot{x: 2, y: 2, direction: :north}
      assert {:ok, %{direction: :east}} = Robot.right(robot)

      robot = %Robot{x: 2, y: 2, direction: :south}
      assert {:ok, %{direction: :west}} = Robot.right(robot)

      robot = %Robot{x: 2, y: 2, direction: :east}
      assert {:ok, %{direction: :south}} = Robot.right(robot)

      robot = %Robot{x: 2, y: 2, direction: :west}
      assert {:ok, %{direction: :north}} = Robot.right(robot)
    end

    test "returns an error if the robot has no direction" do
      robot = %Robot{}
      assert {:error, :invalid_right} = Robot.right(robot)
    end
  end
end
