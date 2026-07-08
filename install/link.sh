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

# Files and directories to symlink (common to all shells)
COMMON_TO_LINK=(
    ".config/alacritty"
    ".config/bat"
    ".config/fish"
    ".config/nvim"
    ".config/starship.toml"
    ".config/tmux"
)

# Helper function to copy file (for bash configurations)
copy_item() {
    local rel_path="$1"
    local src="$DOTFILES_DIR/$rel_path"
    local dst="$HOME_DIR/$rel_path"
    
    if [ ! -e "$src" ]; then
        warn "Source path does not exist: $src"
        return
    fi
    
    mkdir -p "$(dirname "$dst")"
    
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        mv "$dst" "${dst}.bak"
        info "Backed up ~/$rel_path to ~/${rel_path}.bak"
    fi
    
    cp "$src" "$dst"
    success "Copied ~/$rel_path"
}

# Prompt user for shell configuration selection
SHELL_TYPE=""
if [ -t 0 ]; then
    echo ""
    info "Select your shell configuration to install:"
    echo "1) bash (copies .bashrc)"
    echo "2) zsh  (links .zshrc, .zprofile, .zshenv)"
    while true; do
        read -rp "Enter choice [1-2]: " choice
        case "$choice" in
            1|bash|BASH)
                SHELL_TYPE="bash"
                break
                ;;
            2|zsh|ZSH)
                SHELL_TYPE="zsh"
                break
                ;;
            *)
                warn "Invalid choice. Please enter 1 or 2."
                ;;
        esac
    done
else
    # Non-interactive fallback
    if [ -n "$SHELL" ] && [[ "$SHELL" == *"zsh"* ]]; then
        SHELL_TYPE="zsh"
    else
        SHELL_TYPE="bash"
    fi
    info "Non-interactive shell detected. Defaulting to: $SHELL_TYPE"
fi

# Link common configuration files
info "Linking common configurations..."
for item in "${COMMON_TO_LINK[@]}"; do
    symlink_item "$item"
done

# Perform shell-specific configuration
if [ "$SHELL_TYPE" = "bash" ]; then
    info "Setting up Bash configuration..."
    copy_item ".bashrc"
elif [ "$SHELL_TYPE" = "zsh" ]; then
    info "Setting up Zsh configuration..."
    ZSH_TO_LINK=(
        ".zshrc"
        ".zprofile"
        ".zshenv"
    )
    for item in "${ZSH_TO_LINK[@]}"; do
        symlink_item "$item"
    done
fi

success "Symlink and configuration setup completed."
