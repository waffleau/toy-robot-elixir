defmodule ToyRobot do
  alias ToyRobot.{
    Board,
    Command,
    Robot
  }

  @command_file "commands.txt"

  def run() do
    case File.read(@command_file) do
      {:ok, input} -> run(input)
      {:error, _e} -> IO.puts("Could not find file: #{@command_file}")
    end
  end

  def run(input) do
    state = %{
      board: %Board{height: 5, width: 5},
      robot: %Robot{}
    }

    input
    |> Command.from_string()
    |> Enum.reduce(state, &execute_command(&2, &1))
  end

  defp execute_command(state, command) do
    update_robot_state(state, command)
  end

  defp update_robot_state(%{board: board, robot: robot} = state, %Command{name: name, args: args}) do
    robot_command_result =
      case name do
        :left -> Robot.left(robot)
        :move -> Robot.move(robot, board)
        :place -> Robot.place(robot, board, args.x, args.y, args.direction)
        :report -> Robot.report(robot)
        :right -> Robot.right(robot)
        _else -> {:error, :invalid_command}
      end

    case robot_command_result do
      {:ok, delta_robot} -> %{state | robot: delta_robot}
      {:error, _error} -> state
    end
  end
end
