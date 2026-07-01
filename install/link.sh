#!/bin/bash
# Symlink configuration script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
HOME_DIR="$HOME"

info "Creating symlinks..."

symlink_item() {
    local rel_path="$1"
    local src="$DOTFILES_DIR/$rel_path"
    local dst="$HOME_DIR/$rel_path"
    
    if [ ! -e "$src" ]; then
        warn "Source path does not exist: $src"
        return
    fi
    
    mkdir -p "$(dirname "$dst")"
    
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
            info "Already linked: ~/$rel_path"
            return
        fi
        
        mv "$dst" "${dst}.bak"
        info "Backed up ~/$rel_path to ~/${rel_path}.bak"
    fi
    
    ln -sf "$src" "$dst"
    success "Linked ~/$rel_path"
}

# Files and directories to symlink
DOTFILES_TO_LINK=(
    ".zshrc"
    ".zprofile"
    ".zshenv"
    ".config/alacritty"
    ".config/bat"
    ".config/fish"
    ".config/nvim"
    ".config/starship.toml"
    ".config/tmux"
)

for item in "${DOTFILES_TO_LINK[@]}"; do
    symlink_item "$item"
done

success "Symlink setup completed."
