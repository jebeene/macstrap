# read_command_into_array <array_name> <command>
# Equivalent to: mapfile -t array < <(command)
read_command_into_array() {
  local array_name="$1"
  shift

  # Run the remaining arguments as the command
  local cmd_output
  cmd_output="$("$@")"

  local items=()
  while IFS= read -r line || [[ -n "$line" ]]; do
    items+=("$line")
  done < <(printf "%s" "$cmd_output")

  # Export into caller scope
  eval "$array_name=(\"\${items[@]}\")"
}