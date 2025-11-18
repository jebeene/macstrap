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

# Wait for user to confirm before proceeding
gum confirm --padding "1 0 1 0" "Ready to install?" && echo