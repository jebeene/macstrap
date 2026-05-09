#!/bin/bash
# Setup script for VS Code / Cursor themes and config

set -euo pipefail

THEME_SRC="$MACSTRAP_PATH/config/vscode"
THEME_NAME="cursor-dark-anysphere"

echo "Setting up VS Code / Cursor theme..."

for editor_extensions in "$HOME/.vscode/extensions" "$HOME/.cursor/extensions"; do
  if [[ -d "$(dirname "$editor_extensions")" ]]; then
    dest="$editor_extensions/$THEME_NAME"
    mkdir -p "$dest"
    cp "$THEME_SRC/package.json" "$dest/package.json"
    cp "$THEME_SRC/cursor-dark-color-theme.json" "$dest/cursor-dark-color-theme.json"
    echo "Theme installed to $dest"
  fi
done
