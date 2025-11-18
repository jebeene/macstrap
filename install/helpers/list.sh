# read_command_into_array <array_name> <command>
# Equivalent to: mapfile -t array < <(command)
# Note: Uses eval, so doesn't work in subshells
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

# read_command_into_array_local <array_name> <command>
# macOS-compatible version that works in subshells
# Requires the variable to be created as local in the calling scope first
read_command_into_array_local() {
  local array_name="$1"
  shift

  # Read command output into local array (works in subshells)
  eval "$array_name=()"
  while IFS= read -r line || [[ -n "$line" ]]; do
    eval "$array_name+=(\"\$line\")"
  done < <("$@")
}