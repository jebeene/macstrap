#!/bin/bash
# Setup script for uv

set -euo pipefail

if ! command -v uv &>/dev/null; then
  echo "Error: uv is not installed."
  exit 1
fi

echo "Setting up uv..."

mkdir -p "$HOME/.config/uv"
cp "$MACSTRAP_PATH/default/uv/uv.toml" "$HOME/.config/uv/uv.toml"

echo "uv config written to ~/.config/uv/uv.toml"
