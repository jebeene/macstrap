# Hot corners
# Possible values:
#   0: No Option
#   2: Mission Control
#   3: Show application windows
#   4: Show desktop
#   5: Start screen saver
#   6: Disable screen saver
#   7: Dashboard
#  10: Put display to sleep
#  11: Launchpad
#  12: Notification Center
#  13: Lock Screen

# Top left: Show application windows
defaults write com.apple.dock wvous-tl-corner -int 3

# Top right: Mission Control
defaults write com.apple.dock wvous-tr-corner -int 2

# Bottom left: Start screen saver
defaults write com.apple.dock wvous-bl-corner -int 5

# Bottom right: Put display to sleep
defaults write com.apple.dock wvous-br-corner -int 10
