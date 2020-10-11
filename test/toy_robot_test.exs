defmodule ToyRobotTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  describe "scenarios" do
    test "normal movement" do
      commands = """
      PLACE 1,1,NORTH
      MOVE
      MOVE
      RIGHT
      MOVE
      REPORT
      """

      assert capture_io(fn -> ToyRobot.run(commands) end) == "2,3,east\n"
    end

    test "avoid falling" do
      commands = """
      PLACE 1,1,NORTH
      MOVE
      LEFT
      MOVE
      MOVE
      MOVE
      REPORT
      """

      assert capture_io(fn -> ToyRobot.run(commands) end) == "0,2,west\n"
    end

    test "loop back to start" do
      commands = """
      PLACE 1,1,NORTH
      MOVE
      MOVE
      RIGHT
      MOVE
      MOVE
      RIGHT
      MOVE
      MOVE
      RIGHT
      MOVE
      MOVE
      RIGHT
      REPORT
      """

      assert capture_io(fn -> ToyRobot.run(commands) end) == "1,1,north\n"
    end

    test "ignore commands until place" do
      commands = """
      MOVE
      LEFT
      MOVE
      RIGHT
      MOVE
      PLACE 1,1,NORTH
      MOVE
      REPORT
      """

      assert capture_io(fn -> ToyRobot.run(commands) end) == "1,2,north\n"
    end

    test "invalid commands" do
      commands = """
      WHISKEY
      TANGO
      PLACE 1,1,BACKWARDS
      PLACE A,B,C
      REPORTING
      """

      assert capture_io(fn -> ToyRobot.run(commands) end) == ""
    end
  end
end
