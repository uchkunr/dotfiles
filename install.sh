#!/bin/bash
# Dotfiles installer for macOS and Linux (Debian-based)

set -e

REPO="https://github.com/uchkunr/dotfiles"

# OS Detection
OS="$(uname -s)"
case "$OS" in
    Darwin)
        OS_TYPE="macos"
        ;;
    Linux)
        if command -v apt &>/dev/null; then
            OS_TYPE="linux"
        else
            echo "Error: Only macOS and Debian-based Linux are supported." >&2
            exit 1
        fi
        ;;
    *)
        echo "Error: Unsupported OS: $OS" >&2
        exit 1
        ;;
esac

# Resolve Dotfiles Directory
# If script is run directly from the cloned directory, use it. Otherwise, default to $HOME/dotfiles.
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_PATH/Brewfile" ] && [ -d "$SCRIPT_PATH/.config" ]; then
    DOTFILES_DIR="$SCRIPT_PATH"
else
    DOTFILES_DIR="$HOME/dotfiles"
fi

export DOTFILES_DIR

# Clone / Pull repository if needed
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Cloning dotfiles to $DOTFILES_DIR..."
    git clone "$REPO" "$DOTFILES_DIR"
elif [ "$DOTFILES_DIR" = "$HOME/dotfiles" ]; then
    echo "Updating dotfiles at $DOTFILES_DIR..."
    git -C "$DOTFILES_DIR" pull
fi

# Ensure all installer scripts have execute permissions
chmod +x "$DOTFILES_DIR"/install/*.sh

# Load helper utilities
source "$DOTFILES_DIR/install/utils.sh"

# Clean-up function to terminate background sudo keep-alive process
cleanup() {
    if [ -n "$SUDO_PID" ]; then
        kill "$SUDO_PID" 2>/dev/null || true
    fi
}
trap cleanup EXIT INT TERM

# Run sudo keep-alive for Linux
if [ "$OS_TYPE" = "linux" ]; then
    setup_sudo
fi

# Run OS-Specific Installers
if [ "$OS_TYPE" = "macos" ]; then
    bash "$DOTFILES_DIR/install/macos.sh"
elif [ "$OS_TYPE" = "linux" ]; then
    bash "$DOTFILES_DIR/install/linux.sh"
fi

# Run Symlink Configuration
bash "$DOTFILES_DIR/install/link.sh"

# Run Universal npm Packages Installation
bash "$DOTFILES_DIR/install/npm.sh"

echo ""
success "Installation completed successfully."
info "Please restart your shell to apply changes."
