#!/bin/bash
set -e

# macOSの場合のみ実行
if [[ "$(uname)" != "Darwin" ]]; then
  echo "Skipping setup (not macOS)"
  exit 0
fi

echo "=== dotfiles setup ==="

# ---- Homebrew ----
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Installing packages from Brewfile..."
brew bundle --file="$(chezmoi source-path)/Brewfile"

# ---- Rustup ----
if ! command -v rustup &>/dev/null; then
  echo "Installing Rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
fi

echo "Installing Rust components..."
rustup component add rust-analyzer

# ---- Mise ----
if command -v mise &>/dev/null; then
  echo "Installing mise runtimes..."
  mise trust --all
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

echo "=== Setup complete ==="
