# Copy over macstrap configs
mkdir -p ~/.config
cp -R ~/.local/share/macstrap/config/* ~/.config/

# Use default zshrc from macstrap
cp ~/.local/share/macstrap/default/zshrc ~/.zshrc