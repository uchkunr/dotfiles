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
echo "[5/6] Installing packages from Brewfile..."
brew bundle --file="$DOTFILES/Brewfile"

# Symlinks
echo "[6/6] Creating symlinks..."

symlink() {
  local src="$DOTFILES/$1"
  local dst="$HOME/$1"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "${dst}.bak"
    echo "  Backed up existing $(basename "$dst") → $(basename "$dst").bak"
  fi
  ln -sf "$src" "$dst"
  echo "  $1"
}

symlink ".zshrc"
symlink ".zprofile"
symlink ".zshenv"
symlink ".config/nvim"
symlink ".config/fish"
symlink ".config/tmux"
symlink ".config/alacritty"
symlink ".config/bat"
symlink ".config/zed"
symlink ".config/htop"
symlink ".config/karabiner"

echo ""
echo "Done. Restart your terminal to apply changes."
