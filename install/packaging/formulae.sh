#!/bin/bash
# Install all formulae packages
read_command_into_array packages sh -c "grep -v '^#' \"$MACSTRAP_INSTALL/macstrap-formula.packages\" | grep -v '^$'"

if [[ ${#packages[@]} -gt 0 ]]; then
  brew install "${packages[@]}"
fi