#!/bin/bash
# Setup script for bun

set -euo pipefail

if ! command -v bun &>/dev/null; then
  echo "Error: bun is not installed."
  exit 1
fi

echo "Setting up bun..."

cp "$MACSTRAP_PATH/default/bun/bunfig.toml" "$HOME/.bunfig.toml"

echo "bun config written to ~/.bunfig.toml"
