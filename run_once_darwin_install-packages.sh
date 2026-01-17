#!/bin/bash
set -e

echo "=== dotfiles setup (macOS) ==="

# ---- Homebrew ----
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Installing packages from Brewfile..."
brew bundle --file="${CHEZMOI_SOURCE_DIR}/Brewfile"

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
  echo "Setting up mise..."

  # PHP plugin (asdf-php for building from source)
  mise plugins install php https://github.com/asdf-community/asdf-php.git || true

  # PHP build options (required for macOS)
  export PHP_CONFIGURE_OPTIONS="--with-openssl=$(brew --prefix openssl@3) --with-iconv=$(brew --prefix libiconv)"

  mise trust --all
  echo "Installing mise runtimes (PHP may take a while to compile)..."
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
