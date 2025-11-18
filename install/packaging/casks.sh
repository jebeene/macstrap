#!/bin/bash
# Install all cask packages
eval "$(read-command-into-array packages sh -c "grep -v '^#' \"$MACSTRAP_INSTALL/macstrap-cask.packages\" | grep -v '^$'")"

if [[ ${#packages[@]} -gt 0 ]]; then
  brew install --cask "${packages[@]}"
fi