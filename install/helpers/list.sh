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
# Directly populates array without eval for proper quoting
read_command_into_array_local() {
  local array_name="$1"
  shift
  
  # Build the array by reading lines
  local -a temp_array
  while IFS= read -r line || [[ -n "$line" ]]; do
    temp_array+=("$line")
  done < <("$@")
  
  # Use eval to assign to the target variable name in caller scope
  eval "$array_name=(\"\${temp_array[@]}\")"
}