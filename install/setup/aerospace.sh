#!/bin/bash
# Setup script for AeroSpace tiling window manager

set -euo pipefail

if ! command -v aerospace &>/dev/null; then
  echo "Error: AeroSpace is not installed. Run 'brew install --cask aerospace' first."
  exit 1
fi

echo "Setting up AeroSpace..."

# Build ~/.config/aerospace/aerospace.toml from component defaults + user bindings
macstrap-refresh-aerospace

# Register AeroSpace to start at login
aerospace enable login-item 2>/dev/null || true

echo "AeroSpace config written to $HOME/.config/aerospace/aerospace.toml"
echo "Grant Accessibility permission when prompted: System Settings → Privacy & Security → Accessibility"
