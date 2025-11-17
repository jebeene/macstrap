#!/bin/bash
# Setup script for macstrap Neovim configuration
# Deploys Neovim config from the repository to user directories

set -euo pipefail

# Neovim directories (XDG Base Directory Specification, also used on macOS)
CONFIG_DIR="${HOME}/.config/nvim"
DATA_DIR="${HOME}/.local/share/nvim"
CACHE_DIR="${HOME}/.cache/nvim"
STATE_DIR="${HOME}/.local/state/nvim"

# Check if nvim is installed
if ! command -v nvim &> /dev/null; then
  echo "Error: Neovim is not installed. Run 'brew install neovim' first."
  exit 1
fi

# Check if config already exists
if [[ -d "$CONFIG_DIR" ]]; then
  if command -v gum &> /dev/null; then
    if ! gum confirm "Neovim config already exists at $CONFIG_DIR. Overwrite?"; then
      echo "Setup cancelled."
      exit 0
    fi
  else
    echo "Neovim config already exists at $CONFIG_DIR. Skipping setup."
    exit 0
  fi
  
  # Backup existing config
  BACKUP_DIR="${CONFIG_DIR}.backup.$(date +%Y%m%d-%H%M%S)"
  mv "$CONFIG_DIR" "$BACKUP_DIR"
  echo "Backed up existing config to $BACKUP_DIR"
fi

echo "Setting up Neovim configuration..."

# Clean up caches (will be regenerated on first use)
rm -rf "$DATA_DIR" "$CACHE_DIR" "$STATE_DIR"

# Create directories
mkdir -p "$(dirname "$CONFIG_DIR")"
mkdir -p "$(dirname "$DATA_DIR")"
mkdir -p "$(dirname "$CACHE_DIR")"

# Deploy config from repository
cp -r "$MACSTRAP_PATH/config/nvim" "$CONFIG_DIR"

echo "Neovim setup complete!"