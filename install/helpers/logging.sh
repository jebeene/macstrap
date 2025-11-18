start_log_output() {
  local ANSI_SAVE_CURSOR="\033[s"
  local ANSI_RESTORE_CURSOR="\033[u"
  local ANSI_CLEAR_LINE="\033[2K"
  local ANSI_HIDE_CURSOR="\033[?25l"
  local ANSI_RESET="\033[0m"
  local ANSI_GRAY="\033[90m"

  # Save cursor position and hide cursor
  printf $ANSI_SAVE_CURSOR
  printf $ANSI_HIDE_CURSOR

  # Capture parent PID so the child can detect when we're gone
  local parent_pid=$$

  (
    local log_lines=20
    local max_line_width=$((LOGO_WIDTH - 4))

    while true; do
      # If the parent is gone, exit the monitor
      if ! kill -0 "$parent_pid" 2>/dev/null; then
        exit 0
      fi

      # Read the last N lines into an array (using subshell-safe helper)
      read_command_into_array_local current_lines tail -n $log_lines "$MACSTRAP_INSTALL_LOG_FILE" 2>/dev/null

      output=""
      for ((i = 0; i < log_lines; i++)); do
        line="${current_lines[i]:-}"

        if [ ${#line} -gt $max_line_width ]; then
          line="${line:0:$max_line_width}..."
        fi

        if [ -n "$line" ]; then
          output+="${ANSI_CLEAR_LINE}${PADDING_LEFT_SPACES}  → ${line}${ANSI_RESET}\n"
        else
          output+="${ANSI_CLEAR_LINE}${PADDING_LEFT_SPACES}\n"
        fi
      done

      printf "${ANSI_RESTORE_CURSOR}%b" "$output"

      sleep 0.1
    done
  ) &
  monitor_pid=$!
}

stop_log_output() {
  if [ -n "${monitor_pid:-}" ]; then
    kill $monitor_pid 2>/dev/null || true
    wait $monitor_pid 2>/dev/null || true
    unset monitor_pid
  fi
}

start_install_log() {
  mkdir -p "$(dirname "$MACSTRAP_INSTALL_LOG_FILE")"
  touch "$MACSTRAP_INSTALL_LOG_FILE"
  chmod 666 "$MACSTRAP_INSTALL_LOG_FILE"

  export MACSTRAP_START_TIME=$(date '+%Y-%m-%d %H:%M:%S')
  echo "=== Macstrap Installation Started: $MACSTRAP_START_TIME ===" >>"$MACSTRAP_INSTALL_LOG_FILE"
  start_log_output
}

stop_install_log() {
  stop_log_output
  show_cursor

  if [[ -n ${MACSTRAP_INSTALL_LOG_FILE:-} ]]; then
    MACSTRAP_END_TIME=$(date '+%Y-%m-%d %H:%M:%S')
    echo "=== Macstrap Installation Completed: $MACSTRAP_END_TIME ===" >>"$MACSTRAP_INSTALL_LOG_FILE"
    echo "" >>"$MACSTRAP_INSTALL_LOG_FILE"
    echo "=== Installation Time Summary ===" >>"$MACSTRAP_INSTALL_LOG_FILE"

    if [ -n "$MACSTRAP_START_TIME" ]; then
      MACSTRAP_START_EPOCH=$(date -d "$MACSTRAP_START_TIME" +%s)
      MACSTRAP_END_EPOCH=$(date -d "$MACSTRAP_END_TIME" +%s)
      MACSTRAP_DURATION=$((MACSTRAP_END_EPOCH - MACSTRAP_START_EPOCH))

      MACSTRAP_MINS=$((MACSTRAP_DURATION / 60))
      MACSTRAP_SECS=$((MACSTRAP_DURATION % 60))

      echo "Macstrap:     ${MACSTRAP_MINS}m ${MACSTRAP_SECS}s" >>"$MACSTRAP_INSTALL_LOG_FILE"

    fi
    echo "=================================" >>"$MACSTRAP_INSTALL_LOG_FILE"

    echo "Rebooting system..." >>"$MACSTRAP_INSTALL_LOG_FILE"
  fi
}

run_logged() {
  local script="$1"

  export CURRENT_SCRIPT="$script"

  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting: $script" >>"$MACSTRAP_INSTALL_LOG_FILE"

  # Use bash -c to create a clean subshell
  bash -c "source '$script'" </dev/null >>"$MACSTRAP_INSTALL_LOG_FILE" 2>&1

  local exit_code=$?

  if [ $exit_code -eq 0 ]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Completed: $script" >>"$MACSTRAP_INSTALL_LOG_FILE"
    unset CURRENT_SCRIPT
  else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Failed: $script (exit code: $exit_code)" >>"$MACSTRAP_INSTALL_LOG_FILE"
  fi

  return $exit_code
}
