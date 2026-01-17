#!/bin/bash
set -e

echo "=== dotfiles setup (Linux) ==="

# ---- apt packages ----
echo "Installing apt packages..."
sudo apt update
sudo apt install -y \
  zsh \
  zsh-autosuggestions \
  zsh-syntax-highlighting \
  fzf \
  vim \
  git \
  curl \
  ripgrep \
  fd-find \
  bat \
  jq \
  htop

# ---- Starship ----
if ! command -v starship &>/dev/null; then
  echo "Installing Starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# ---- Rustup ----
if ! command -v rustup &>/dev/null; then
  echo "Installing Rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
fi

echo "Installing Rust components..."
rustup component add rust-analyzer

# ---- Mise ----
if ! command -v mise &>/dev/null; then
  echo "Installing Mise..."
  curl https://mise.run | sh
  export PATH="$HOME/.local/bin:$PATH"
fi

if command -v mise &>/dev/null; then
  echo "Setting up mise..."

  # PHP plugin
  mise plugins install php https://github.com/asdf-community/asdf-php.git || true

  mise trust --all
  echo "Installing mise runtimes..."
  mise install
fi

# ---- Go tools ----
if command -v go &>/dev/null; then
  echo "Installing Go tools..."
  go install golang.org/x/tools/gopls@latest
  go install github.com/go-delve/delve/cmd/dlv@latest
  go install golang.org/x/tools/cmd/goimports@latest
  go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
fi

# ---- Cargo tools ----
if command -v cargo &>/dev/null; then
  echo "Installing Cargo tools..."
  cargo install filetree || true
  cargo install keifu || true
fi

# ---- Set zsh as default shell ----
if [[ "$SHELL" != *"zsh"* ]]; then
  echo "Setting zsh as default shell..."
  chsh -s $(which zsh)
fi

echo "=== Setup complete ==="
