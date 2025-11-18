gum style --foreground 3 --padding "1 0 0 $PADDING_LEFT" "Installing..."
echo

# Pre-authorize sudo so homebrew can move apps without interrupting the install
echo "Requesting elevated privileges for installation..."
sudo -v

start_install_log