if status is-interactive
    set fish_greeting ""
    starship init fish | source

    function ls
        eza --git --icons=always $argv
    end

    function ll
        eza -l --icons=always $argv
    end

    function la
        eza -A --icons=always $argv
    end

    function l
        eza -l --color --icons=always $argv
    end

    alias vim nvim
    alias mkdir 'mkdir -p'

    alias g git
    alias gaa 'git add .'
    alias gc 'git commit'
    alias gs 'git status'
    alias gp 'git push'
    alias gpd 'git push origin dev'
    alias gl 'git pull'
    alias gco 'git checkout'
    alias gb 'git branch'
    alias gd 'git diff'

    set -gx FZF_DEFAULT_OPTS "--height 80% --layout=reverse --border --info=inline --preview 'bat --style=numbers --color=always {} | head -100'"

    function fzf_configure_custom
        fzf_configure_bindings --directory=\ef --history=\er --processes=\ep --variables=\ev
    end

    function fzf_file_search
        set -l file (fd --type f --color always | fzf --ansi --preview 'bat --style=numbers --color=always --line-range :40 {}')
        and commandline -i -- (realpath $file)
    end

    bind alt-t fzf_file_search

    fzf_configure_custom

end

source ~/.orbstack/shell/init2.fish 2>/dev/null || :
