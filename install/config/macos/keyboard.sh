# Keyboard repeat speed
defaults write NSGlobalDomain KeyRepeat -int 2           # smaller = faster
defaults write NSGlobalDomain InitialKeyRepeat -int 15   # delay before repeat

# Disable press-and-hold (enable real repeats)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false