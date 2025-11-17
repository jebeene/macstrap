if [[ -n "${MACSTRAP_GIT_NAME//[[:space:]]/}" ]]; then
  git config --global user.name "$MACSTRAP_GIT_NAME"
fi

if [[ -n "${MACSTRAP_GIT_EMAIL//[[:space:]]/}" ]]; then
  git config --global user.email "$MACSTRAP_GIT_EMAIL"
fi