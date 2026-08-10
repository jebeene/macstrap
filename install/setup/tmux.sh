#!/bin/bash
# Setup script for tmux

set -euo pipefail

if ! command -v tmux &>/dev/null; then
  echo "Error: tmux is not installed. Run 'brew install tmux' first."
  exit 1
fi

echo "Setting up tmux..."

OUTPUT="$HOME/.config/tmux/tmux.conf"
mkdir -p "$(dirname "$OUTPUT")"
cp "$MACSTRAP_PATH/config/tmux/tmux.conf" "$OUTPUT"

echo "tmux config written to $OUTPUT"
