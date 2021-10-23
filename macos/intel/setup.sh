#!/usr/bin/env bash
if [ "$(uname -s)" != "Darwin" ]; then
	exit 0
fi

set -eu

sudo -v

# workdir
cd $HOME

# macos settings
## dock
defaults write com.apple.dock tilesize -int 50
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 40
defaults write com.apple.dock orientation -string "left"
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock static-only -boolean true

## trackpad
defaults write -g com.apple.mouse.tapBehavior -int 1 
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true && \
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

## Finder
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
chflags nohidden ~/Library
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

## window
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

## keyboard
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write -g ApplePressAndHoldEnabled -bool false

## other
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
defaults write NSGlobalDomain AppleAquaColorVariant -int 6
defaults write NSGlobalDomain AppleHighlightColor -string "0.847059 0.847059 0.862745"
defaults write com.apple.menuextra.battery ShowPercent -bool true

## Reflect
for app in "Activity Monitor" "cfprefsd" \
	"Dock" "Finder" "Safari" "SystemUIServer" \
	"Terminal"; do
	killall "$app" >/dev/null 2>&1
done

## xcode
xcode-select --install
