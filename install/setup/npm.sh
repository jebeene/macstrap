#!/bin/bash
# Setup script for npm

set -euo pipefail

if ! command -v npm &>/dev/null; then
  echo "Error: npm is not installed."
  exit 1
fi

echo "Setting up npm..."

cp "$MACSTRAP_PATH/default/npm/npmrc" "$HOME/.npmrc"

echo "npm config written to ~/.npmrc"
