#!/bin/bash
# Install all python packages
eval "$(read-command-into-array packages sh -c "grep -v '^#' \"$MACSTRAP_INSTALL/macstrap-python.packages\" | grep -v '^$'")"

if [[ ${#packages[@]} -gt 0 ]]; then
  pipx install "${packages[@]}"
fi