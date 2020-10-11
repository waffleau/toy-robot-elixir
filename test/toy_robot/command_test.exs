defmodule ToyRobot.CommandTest do
  use ExUnit.Case

  alias ToyRobot.Command

  describe "from_string/1" do
    test "left command" do
      assert [%Command{name: :left}] == Command.from_string("left")
      assert [%Command{name: :left}] == Command.from_string("Left")
      assert [%Command{name: :left}] == Command.from_string("LEFT")
    end

    test "move command" do
      assert [%Command{name: :move}] == Command.from_string("move")
      assert [%Command{name: :move}] == Command.from_string("Move")
      assert [%Command{name: :move}] == Command.from_string("MOVE")
    end

    test "place command" do
      command = %Command{name: :place, args: %{x: 1, y: 2, direction: :north}}
      assert [command] == Command.from_string("place 1,2,north")

      command = %Command{name: :place, args: %{x: 3, y: 3, direction: :south}}
      assert [command] == Command.from_string("Place 3,3,South")

      command = %Command{name: :place, args: %{x: 0, y: 4, direction: :east}}
      assert [command] == Command.from_string("PLACE 0,4,EAST")
    end

    test "report command" do
      assert [%Command{name: :report}] == Command.from_string("report")
      assert [%Command{name: :report}] == Command.from_string("Report")
      assert [%Command{name: :report}] == Command.from_string("REPORT")
    end

    test "right command" do
      assert [%Command{name: :right}] == Command.from_string("right")
      assert [%Command{name: :right}] == Command.from_string("Right")
      assert [%Command{name: :right}] == Command.from_string("RIGHT")
    end

    test "handles multline commands and preserves ordering" do
      input = "left\nRight\nmove\nREPORT\n"

      expected = [
        %Command{name: :left},
        %Command{name: :right},
        %Command{name: :move},
        %Command{name: :report}
      ]

      assert expected == Command.from_string(input)
    end
  end
end
