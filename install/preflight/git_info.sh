set -euo pipefail

MACSTRAP_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/macstrap"
MACSTRAP_ENV_FILE="$MACSTRAP_CONFIG_DIR/env"
mkdir -p "$MACSTRAP_CONFIG_DIR"

[[ -f "$MACSTRAP_ENV_FILE" ]] && source "$MACSTRAP_ENV_FILE"

MACSTRAP_GIT_NAME=$(gum input --placeholder "Git user.name" --value "${MACSTRAP_GIT_NAME:-}")
MACSTRAP_GIT_EMAIL=$(gum input --placeholder "Git user.email" --value "${MACSTRAP_GIT_EMAIL:-}")

cat > "$MACSTRAP_ENV_FILE" <<EOF
MACSTRAP_GIT_NAME="${MACSTRAP_GIT_NAME}"
MACSTRAP_GIT_EMAIL="${MACSTRAP_GIT_EMAIL}"
EOF

export MACSTRAP_GIT_NAME MACSTRAP_GIT_EMAIL

# Generate SSH key (will pause for file location and passphrase)
ssh-keygen -t ed25519 -C "$MACSTRAP_GIT_EMAIL"

# Determine the key file location (default is ~/.ssh/id_ed25519)
SSH_KEY_FILE="${HOME}/.ssh/id_ed25519"
SSH_PUB_KEY_FILE="${SSH_KEY_FILE}.pub"

# Display the public key and instructions
echo ""
gum style --foreground 2 --bold "SSH Key Generated Successfully!"
echo ""
gum style --foreground 7 "Your public key is:"
echo ""
gum style --foreground 6 "$(cat "$SSH_PUB_KEY_FILE")"
echo ""
gum style --foreground 7 "Please add this public key to your GitHub account:"
echo ""
gum style --foreground 3 "  1. Go to https://github.com/settings/keys"
gum style --foreground 3 "  2. Click 'New SSH key'"
gum style --foreground 3 "  3. Paste the public key above"
echo ""

# Wait for user to confirm they've added the key to GitHub
gum confirm --padding "1 0 1 0" "Have you added the SSH key to your GitHub account?" || exit 1

# Wait for user to confirm before proceeding
gum confirm --padding "1 0 1 0" "Ready to install?" && echo