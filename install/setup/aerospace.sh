#!/bin/bash
# Setup script for AeroSpace tiling window manager

set -euo pipefail

if ! command -v aerospace &>/dev/null; then
  echo "Error: AeroSpace is not installed. Run 'brew install --cask aerospace' first."
  exit 1
fi

echo "Setting up AeroSpace..."

# Build ~/.aerospace.toml by merging system defaults with user bindings
BASE="$MACSTRAP_PATH/default/aerospace/aerospace.toml"
USER_BINDINGS="$MACSTRAP_PATH/config/aerospace/bindings.toml"
OUTPUT="$HOME/.aerospace.toml"

python3 -c "
base = open('$BASE').read()
user = open('$USER_BINDINGS').read()
print(base.replace('# __USER_BINDINGS__', user), end='')
" > "$OUTPUT"

# Register AeroSpace to start at login
aerospace enable login-item 2>/dev/null || true

echo "AeroSpace config written to ~/.aerospace.toml"
echo "Grant Accessibility permission when prompted: System Settings → Privacy & Security → Accessibility"
