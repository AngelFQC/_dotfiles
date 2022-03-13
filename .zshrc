setopt PROMPT_SUBST

alias ll="ls -l"
alias la="ls -la"

function cdw {
    dir_www="/var/www"
    dir_to_move=$(ls "$dir_www" | fzf)

    cd "$dir_www/$dir_to_move"
}

alias gs="git status"
alias gd="git diff"

function gc {
    if [ -z "$1" ]; then
        git commit
    else
        git commit -m "$1"
    fi
}

_reverse_search() {
    local selected_command=$(fc -rl 1 | awk '{$1="";print substr($0,2)}' | fzf)

    LBUFFER=$selected_command
}

zle     -N      _reverse_search
bindkey '^r'    _reverse_search

# prompt

function prompt_exit_code() {
    local EXIT="$?"

    if [ $EXIT -eq 0 ]; then
        echo -n green
    else
        echo -n red
    fi
}

function git_prompt_info() {
    inside_git_repo="$(git rev-parse --is-inside-work-tree 2> /dev/null)"

    if [ "$inside_git_repo" ]; then
        current_branch=$(git branch --show-current)
        print -P " on %{%F{yellow}%}$current_branch%{%f%}"
    else
        echo ""
    fi
}

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"
