# Dock: auto-hide
defaults write com.apple.dock autohide -bool true

# Dock: orientation (left, bottom, right)
defaults write com.apple.dock orientation -string "left"

# Dock: magnification (on/off) and size when magnified
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock largesize -int 128

# Dock: minimize effect (genie or scale)
defaults write com.apple.dock mineffect -string "genie"

# Dock: group Mission Control windows by app
defaults write com.apple.dock "expose-group-apps" -bool false

# Dock: “minimize windows into application icon”
defaults write com.apple.dock "minimize-to-application" -bool false

# Dock: automatically rearrange Spaces based on recent use
defaults write com.apple.dock "mru-spaces" -bool false