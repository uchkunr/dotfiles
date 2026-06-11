#!/bin/bash

set -e

DOTFILES="$HOME/dotfiles"
REPO="https://github.com/uchkunr/dotfiles"

echo "Starting setup..."
echo ""

# Homebrew
if ! command -v brew &>/dev/null; then
  echo "[1/5] Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "[1/5] Homebrew already installed, skipping."
fi

# Bun
if ! command -v bun &>/dev/null; then
  echo "[2/5] Installing Bun..."
  curl -fsSL https://bun.sh/install | bash
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
else
  echo "[2/5] Bun already installed, skipping."
fi

# Claude Code
if ! command -v claude &>/dev/null; then
  echo "[3/5] Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
else
  echo "[3/5] Claude Code already installed, skipping."
fi

# Clone dotfiles
if [ ! -d "$DOTFILES" ]; then
  echo "[4/5] Cloning dotfiles..."
  git clone "$REPO" "$DOTFILES"
else
  echo "[4/5] Dotfiles already cloned, pulling latest..."
  git -C "$DOTFILES" pull
fi

# Brew bundle
echo "[5/5] Installing packages from Brewfile..."
brew bundle --file="$DOTFILES/Brewfile"

echo ""
echo "Done. Symlink your configs manually or restart your terminal."
