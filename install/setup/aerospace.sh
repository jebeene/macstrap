#!/bin/bash
# Setup script for AeroSpace tiling window manager

set -euo pipefail

if ! command -v aerospace &>/dev/null; then
  echo "Error: AeroSpace is not installed. Run 'brew install --cask aerospace' first."
  exit 1
fi

echo "Setting up AeroSpace..."

# Build ~/.config/aerospace/aerospace.toml from component defaults + user bindings (no reload yet)
macstrap-refresh-aerospace --no-reload
echo "AeroSpace config written to $HOME/.config/aerospace/aerospace.toml"

# Launch AeroSpace — it will prompt for Accessibility permission on first run
open -a AeroSpace

echo ""
echo "AeroSpace requires Accessibility permission to manage windows."
echo "  → System Settings → Privacy & Security → Accessibility → enable AeroSpace"
echo ""
read -rp "Press Enter once you've granted Accessibility permission..."

# Register AeroSpace to start at login and reload the config
aerospace enable login-item 2>/dev/null || true
aerospace reload-config
