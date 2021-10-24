#!/usr/bin/env bash
if [ "$(uname -s)" != "Darwin" ]; then
	exit 0
fi

set -eu

# workdir
cd $HOME

# homebrew
## install
which brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## update & upgrade
brew update && brew upgrade

## install formula
formulas=(
    bat
    ctop
    exa
    ffmpeg
    fd
    fish
    gh
    git
    go
    htop
    mas
    nb
    nkf
    neofetch
    nvm
    pandoc
    procs
    pstree
    rustup
    sd
    tfenv
    thefuck
    tldr
    tmux
    tree
)

for formula in "${formulas[@]}"; do
    brew install $formula || brew upgrade $formula
done

## install casks
casks=(
    appcleaner
    deepl
    discord
    docker
    filezilla
    firefox
    google-chrome
    google-japanese-ime
    iterm2
    slack
    visual-studio-code
)

for cask in "${casks[@]}"; do
    brew install --cask $cask
done

## complate
brew cleanup