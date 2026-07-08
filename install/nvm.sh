#!/bin/bash
# Universal NVM (Node Version Manager) installer

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

export NVM_DIR="$HOME/.nvm"

info "Checking NVM installation..."

# Source NVM if it exists
if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
fi

if has_cmd nvm; then
    info "NVM is already installed."
else
    info "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    
    # Load NVM for the current session
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        source "$NVM_DIR/nvm.sh"
    else
        error "Failed to load NVM after installation."
        exit 1
    fi
    success "NVM installed successfully."
fi

# Ensure Node.js LTS is installed
if ! has_cmd node; then
    info "Installing Node.js LTS version..."
    nvm install --lts
    nvm use --lts
    success "Node.js LTS installed."
else
    info "Node.js is already installed ($(node -v))."
fi
