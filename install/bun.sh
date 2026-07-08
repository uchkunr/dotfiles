#!/bin/bash
# Universal Bun installer

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

info "Checking Bun installation..."

# Source Bun environment if it exists
export BUN_INSTALL="$HOME/.bun"
if [ -d "$BUN_INSTALL" ]; then
    export PATH="$BUN_INSTALL/bin:$PATH"
fi

if has_cmd bun; then
    info "Bun is already installed ($(bun -v))."
else
    info "Installing Bun..."
    curl -fsSL https://bun.sh/install | bash
    
    # Load Bun for the current session
    export PATH="$BUN_INSTALL/bin:$PATH"
    
    if has_cmd bun; then
        success "Bun installed successfully."
    else
        error "Failed to verify Bun installation after running setup."
        exit 1
    fi
fi
