#!/bin/bash
# Linux installer script (Debian-based)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

info "Starting Linux setup..."

# Update apt cache
info "Updating apt index..."
sudo apt update -y

# Install packages from packages.apt
if [ -f "$SCRIPT_DIR/packages.apt" ]; then
    info "Installing packages from packages.apt..."
    PACKAGES=()
    while IFS= read -r pkg || [ -n "$pkg" ]; do
        [[ "$pkg" =~ ^# ]] && continue
        [[ -z "${pkg// }" ]] && continue
        PACKAGES+=("$pkg")
    done < "$SCRIPT_DIR/packages.apt"
    
    if [ ${#PACKAGES[@]} -gt 0 ]; then
        sudo apt install -y "${PACKAGES[@]}"
    fi
else
    warn "packages.apt not found."
fi

# Set up batcat to bat symlink if needed
if has_cmd batcat && ! has_cmd bat; then
    info "Symlinking batcat to bat..."
    mkdir -p "$HOME/.local/bin"
    ln -sf /usr/bin/batcat "$HOME/.local/bin/bat"
    export PATH="$HOME/.local/bin:$PATH"
fi

# Install eza
if ! has_cmd eza; then
    info "Installing eza..."
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
else
    info "eza is already installed."
fi

# Install Starship
if ! has_cmd starship; then
    info "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
else
    info "Starship is already installed."
fi

# Install uv
if ! has_cmd uv; then
    info "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
else
    info "uv is already installed."
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



# Install Google Chrome
if ! has_cmd google-chrome && ! has_cmd google-chrome-stable; then
    info "Installing Google Chrome..."
    wget -q -O /tmp/google-chrome-stable.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
    sudo apt install -y /tmp/google-chrome-stable.deb
    rm /tmp/google-chrome-stable.deb
else
    info "Google Chrome is already installed."
fi

# Install VS Code
if ! has_cmd code; then
    info "Installing VS Code..."
    wget -q -O /tmp/vscode-stable.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
    sudo apt install -y /tmp/vscode-stable.deb
    rm /tmp/vscode-stable.deb
else
    info "VS Code is already installed."
fi

# Install Flatpak Apps
if has_cmd flatpak; then
    info "Setting up Flathub..."
    flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    
    if [ -f "$SCRIPT_DIR/packages.flatpak" ]; then
        info "Installing applications from packages.flatpak..."
        while IFS= read -r app || [ -n "$app" ]; do
            [[ "$app" =~ ^# ]] && continue
            [[ -z "${app// }" ]] && continue
            
            info "Installing Flatpak: $app..."
            flatpak install --user -y flathub "$app" || warn "Failed to install Flatpak: $app"
        done < "$SCRIPT_DIR/packages.flatpak"
    fi
else
    warn "Flatpak is not installed."
fi

success "Linux setup completed."
