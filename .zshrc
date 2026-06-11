# Loaded for interactive shells only — aliases, prompt, completions, plugins.
# Env vars belong in ~/.zshenv; PATH belongs in ~/.zprofile.

eval "$(starship init zsh)"

# Aliases
alias ls='eza --git --icons=always $@'
alias ll='eza -l --icons=always $@'
alias la='eza -A --icons=always $@'
alias l='eza -l --color --icons=always $@'

alias vim='nvim'
alias mkdir='mkdir -p'
alias cat='bat'
alias g='git'
alias gaa='git add .'
alias gc='git commit'
alias gs='git status'
alias gp='git push'
alias gpd='git push origin dev'
alias gl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'

alias python="python3"

# Plugins
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/etc/profile.d/z.sh

# nvm (sourced here so the `nvm` function is available interactively)
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# bun completions
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# Secrets (not tracked in dotfiles)
[ -f ~/.secrets ] && source ~/.secrets
