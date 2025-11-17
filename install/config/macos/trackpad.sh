# Trackpad speed
defaults write NSGlobalDomain "com.apple.trackpad.scaling" -float 0.6875

# Trackpad force click
defaults write NSGlobalDomain "com.apple.trackpad.forceClick" -int 1

# Tap to click (0=off, 1=on)
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 0

# Secondary click
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 1

# Gestures
defaults write com.apple.AppleMultitouchTrackpad TrackpadScroll -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadMomentumScroll -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadPinch -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -int 1

# Swipe gestures (0=off, 1=some mode, 2=system default)
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3
