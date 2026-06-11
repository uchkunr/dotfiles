# Loaded for login shells, AFTER /etc/zprofile (which runs path_helper).
# This is the right place to set PATH on macOS.

eval "$(/opt/homebrew/bin/brew shellenv)"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# PATH additions (prepended in priority order)
export PATH="$HOME/.local/bin:$BUN_INSTALL/bin:$HOME/.opencode/bin:/opt/homebrew/opt/libpq/bin:$PATH:$HOME/.dotnet/tools"
