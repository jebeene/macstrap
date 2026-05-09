#!/bin/bash
# Setup script for AeroSpace tiling window manager

set -euo pipefail

if ! command -v aerospace &>/dev/null; then
  echo "Error: AeroSpace is not installed. Run 'brew install --cask aerospace' first."
  exit 1
fi

echo "Setting up AeroSpace..."

# Build ~/.config/aerospace/aerospace.toml by merging system defaults with user bindings
BASE="$MACSTRAP_PATH/default/aerospace/aerospace.toml"
USER_BINDINGS="$HOME/.config/macstrap/aerospace/bindings.toml"
OUTPUT="$HOME/.config/aerospace/aerospace.toml"

# Seed user bindings from macstrap default if not yet created
if [[ ! -f "$USER_BINDINGS" ]]; then
  mkdir -p "$(dirname "$USER_BINDINGS")"
  cp "$MACSTRAP_PATH/config/aerospace/bindings.toml" "$USER_BINDINGS"
fi

mkdir -p "$(dirname "$OUTPUT")"
python3 -c "
base = open('$BASE').read()
user = open('$USER_BINDINGS').read()
print(base.replace('# __USER_BINDINGS__', user), end='')
" > "$OUTPUT"

# Register AeroSpace to start at login
aerospace enable login-item 2>/dev/null || true

echo "AeroSpace config written to $OUTPUT"
echo "Grant Accessibility permission when prompted: System Settings → Privacy & Security → Accessibility"
