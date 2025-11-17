run_logged $MACSTRAP_INSTALL/config/macos/apple-intelligence.sh
run_logged $MACSTRAP_INSTALL/config/macos/desktop.sh
run_logged $MACSTRAP_INSTALL/config/macos/finder.sh
run_logged $MACSTRAP_INSTALL/config/macos/keyboard.sh
run_logged $MACSTRAP_INSTALL/config/macos/menubar.sh
run_logged $MACSTRAP_INSTALL/config/macos/mouse.sh
run_logged $MACSTRAP_INSTALL/config/macos/text.sh
run_logged $MACSTRAP_INSTALL/config/macos/trackpad.sh
run_logged $MACSTRAP_INSTALL/config/macos/ui.sh

killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true  