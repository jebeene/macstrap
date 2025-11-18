#!/usr/bin/env bash

# Exit immediately on errors and propagate ERR traps
set -eEo pipefail

# Mark that we're running via the online/bootstrap path (if you ever care inside macstrap)
export MACSTRAP_ONLINE_INSTALL=true

ansi_art='
                                                    ░██                                   
                                                    ░██                                   
░█████████████   ░██████    ░███████   ░███████  ░████████ ░██░████  ░██████   ░████████  
░██   ░██   ░██       ░██  ░██    ░██ ░██           ░██    ░███           ░██  ░██    ░██ 
░██   ░██   ░██  ░███████  ░██         ░███████     ░██    ░██       ░███████  ░██    ░██ 
░██   ░██   ░██ ░██   ░██  ░██    ░██        ░██    ░██    ░██      ░██   ░██  ░███   ░██ 
░██   ░██   ░██  ░█████░██  ░███████   ░███████      ░████ ░██       ░█████░██ ░██░█████  
                                                                               ░██        
                                                                               ░██        
                                                                                          
'

clear
echo -e "\n$ansi_art\n"

# --- Ensure git is available (or trigger Xcode CLI tools) --------------------

if ! command -v git &>/dev/null; then
  echo "git is not available on this system."
  echo "On macOS, you need the Xcode Command Line Tools installed."
  echo "Triggering the installer (a GUI dialog should appear)..."
  xcode-select --install || true
  echo
  echo "After the Command Line Tools finish installing, re-run this script."
  exit 1
fi

# --- Repo + path configuration ----------------------------------------------

# Use custom repo if specified, otherwise default to your GitHub macstrap repo.
# Change this default if you host macstrap somewhere else.
MACSTRAP_REPO="${MACSTRAP_REPO:-jebeene/macstrap}"


echo -e "\nCloning macstrap from: https://github.com/${MACSTRAP_REPO}.git"
rm -rf ~/.local/share/macstrap
git clone "https://github.com/${MACSTRAP_REPO}.git" ~/.local/share/macstrap >/dev/null

# --- Optional: use a specific ref/branch/tag --------------------------------

# Use custom branch if instructed, otherwise default to master
MACSTRAP_REF="${MACSTRAP_REF:-main}"
if [[ "$MACSTRAP_REF" != "main" ]]; then
  echo -e "\e[32mUsing ref: $MACSTRAP_REF\e[0m"
  cd ~/.local/share/macstrap
  git fetch origin "$MACSTRAP_REF" && git checkout "$MACSTRAP_REF"
  cd -
fi

# --- Run the actual installer inside macstrap --------------------------------

echo -e "\nInstallation starting..."
# macstrap.sh is your main orchestrator (the thing that sources install/helpers/all.sh etc.)
source ~/.local/share/macstrap/install.sh