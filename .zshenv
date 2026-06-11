# Loaded for ALL zsh invocations (interactive, scripts, non-interactive).
# DO NOT set PATH here on macOS — /etc/zprofile's path_helper runs after this
# and will reorder it. Put PATH in ~/.zprofile instead.

export EDITOR='nvim'

# Tool homes (used by tools themselves and by ~/.zprofile to build PATH)
export NVM_DIR="$HOME/.nvm"
export BUN_INSTALL="$HOME/.bun"

# libpq (keg-only) — so compilers and pkg-config can find headers/libs
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"
