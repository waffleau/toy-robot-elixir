# Usage

## Running the application

`mix run -e "ToyRobot.run()"`

This will read input commands from `commands.txt`. Malformed commands will be ignored.

## Run the tests

`mix test`

# Design notes

## Error states

There are two classes or error:

- An input command is malformed (incorrect syntax or unknown command/args)
- The command is valid, but cannot be applied to the robot in its current state

These are consumed internally, but they are not output to the user. This could go either way, but it made sense to treat the robot as a black box where it receives command which may or not be understood. Much like if you tried to get a dog to perform a trick it didn't know - it just wouldn't do anything.

## Command execution

The logic for executing a command should probably be split into another module, but given these are pretty simple at the moment this could happen later as complexity increases. The general pattern of command logic:

`(current_state, command) -> new_state`
