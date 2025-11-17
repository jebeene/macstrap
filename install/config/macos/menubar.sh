# Disable date separators in the menu bar
defaults write com.apple.menuextra.clock "FlashDateSeparators" -bool "false"

# Auto-hide menu bar
defaults write NSGlobalDomain _HIHideMenuBar -bool true

# Date / Clock format
defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d  HH:mm"
