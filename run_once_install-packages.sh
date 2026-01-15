#!/bin/bash

# macOSの場合のみ実行
if [[ "$(uname)" != "Darwin" ]]; then
  echo "Skipping Homebrew setup (not macOS)"
  exit 0
fi

# Homebrewがなければインストール
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Brewfileからインストール
echo "Installing packages from Brewfile..."
brew bundle --file="$(chezmoi source-path)/Brewfile"
