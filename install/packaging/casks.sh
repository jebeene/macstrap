#!/bin/bash
# Install all cask packages
eval "$(read-command-into-array packages sh -c "grep -v '^#' \"$MACSTRAP_INSTALL/macstrap-cask.packages\" | grep -v '^$'")"

if [[ ${#packages[@]} -gt 0 ]]; then
  # Use --force to skip confirmation prompts
  # Credentials should already be cached via sudo -v in begin.sh
  brew install --cask --force "${packages[@]}" || true
fi