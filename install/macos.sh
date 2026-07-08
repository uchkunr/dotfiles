#!/bin/bash
# macOS installer script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

info "Starting macOS setup..."

# Install Homebrew
if ! has_cmd brew; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    if [ -f "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -f "/usr/local/bin/brew" ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    info "Homebrew is already installed."
fi

# Run brew bundle
if [ -f "$DOTFILES_DIR/Brewfile" ]; then
    info "Installing packages from Brewfile..."
    brew bundle --file="$DOTFILES_DIR/Brewfile"
else
    warn "Brewfile not found at $DOTFILES_DIR/Brewfile."
fi

# Install Bun
if ! has_cmd bun; then
    info "Installing Bun..."
    curl -fsSL https://bun.sh/install | bash
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
else
    info "Bun is already installed."
fi



success "macOS setup completed."
