#!/bin/bash
# Universal npm packages installer

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

NPM_PACKAGES=(
    "@google/gemini-cli"
    "@openai/codex"
    "pnpm"
    "fast-ncu"
    "@anthropic-ai/claude-code"
)

# Load NVM if it exists
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
fi

# If npm is still not found, try to install NVM & Node.js automatically
if ! has_cmd npm; then
    info "Node.js/npm not found. Attempting to install Node Version Manager (NVM)..."
    
    # Download and run NVM installer
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    
    # Load NVM
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        source "$NVM_DIR/nvm.sh"
        info "Installing Node.js LTS version..."
        nvm install --lts
        nvm use --lts
    else
        error "Failed to load NVM after installation."
    fi
fi

# Re-verify if npm is now available
if ! has_cmd npm; then
    error "npm is not installed and NVM setup failed. Skipping global npm packages."
    exit 1
fi

info "Installing global npm packages..."
for pkg in "${NPM_PACKAGES[@]}"; do
    info "Installing $pkg globally..."
    # Attempt normal install (using prefix or NVM which doesn't need sudo)
    if npm install -g "$pkg"; then
        success "Successfully installed $pkg"
    else
        warn "Failed to install $pkg without sudo. Retrying with sudo..."
        if sudo npm install -g "$pkg"; then
            success "Successfully installed $pkg with sudo"
        else
            error "Failed to install $pkg"
        fi
    fi
done

success "Global npm packages setup completed."
