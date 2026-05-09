# Copy over macstrap configs
mkdir -p ~/.config
cp -R ~/.local/share/macstrap/config/* ~/.config/

# Use default zshrc from macstrap if it exists
if [[ -f ~/.local/share/macstrap/default/zshrc ]]; then
  cp ~/.local/share/macstrap/default/zshrc ~/.zshrc
fi

# Seed zshenv for env vars needed by all zsh processes (scripts, GUI tools, etc.)
if [[ -f ~/.local/share/macstrap/default/zshenv ]]; then
  cp ~/.local/share/macstrap/default/zshenv ~/.zshenv
fi