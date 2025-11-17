#!/bin/bash
# Install all python packages
read_command_into_array packages sh -c "grep -v '^#' \"$MACSTRAP_INSTALL/macstrap-python.packages\" | grep -v '^$'"

if [[ ${#packages[@]} -gt 0 ]]; then
  pipx install "${packages[@]}"
fi