#!/usr/bin/env bash

set -eu

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
killall Dock

## trackpad
defaults write -g com.apple.mouse.tapBehavior -int 1 
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true && \
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

## Finder
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

## other
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'homebrew install success'

