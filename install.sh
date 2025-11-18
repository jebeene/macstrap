#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Define Omarchy locations
export MACSTRAP_PATH="${HOME}/.local/share/macstrap"
# export MACSTRAP_PATH="${HOME}/macstrap"
export MACSTRAP_INSTALL="$MACSTRAP_PATH/install"
export MACSTRAP_INSTALL_LOG_FILE="$MACSTRAP_PATH/logs/macstrap-install.log"
export PATH="$MACSTRAP_PATH/bin:$PATH"

# Install
source "$MACSTRAP_INSTALL/helpers/all.sh"
source "$MACSTRAP_INSTALL/preflight/all.sh"
source "$MACSTRAP_INSTALL/packaging/all.sh"
source "$MACSTRAP_INSTALL/setup/all.sh"