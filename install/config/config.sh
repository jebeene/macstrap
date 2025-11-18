# Copy over macstrap configs
mkdir -p ~/.config
cp -R ~/.local/share/macstrap/config/* ~/.config/

# Use default zshrc from macstrap if it exists
if [[ -f ~/.local/share/macstrap/default/zshrc ]]; then
  cp ~/.local/share/macstrap/default/zshrc ~/.zshrc
fi