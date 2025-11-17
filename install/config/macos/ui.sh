# Dark mode (macOS may override this via System Settings UI, but this is fine as a default)
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Double-click title bar zooms instead of minimizes
defaults write NSGlobalDomain AppleActionOnDoubleClick -string "Maximize"
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool false
