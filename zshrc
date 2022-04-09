setopt PROMPT_SUBST

alias ll="ls -l"
alias la="ls -la"

function cdw {
    dir_www="/var/www"
    dir_to_move=$(ls "$dir_www" | fzf)

    cd "$dir_www/$dir_to_move"
}

# git

alias gst='git status'
alias gco='git checkout $1'
alias gcom='git checkout master'
alias glgg='git log --graph --oneline'

function gdv() {
    if [ -z "$1" ]; then
       git diff | vim -
   else
       git diff "$1" | vim -
   fi 
}

function gc {
    if [ -z "$1" ]; then
        git commit
    else
        git commit -m "$1"
    fi
}

# end git

_reverse_search() {
    local selected_command=$(fc -rl 1 | awk '{$1="";print substr($0,2)}' | fzf)

    LBUFFER=$selected_command
}

zle     -N      _reverse_search
bindkey '^r'    _reverse_search

source ~/.dracula-zsh-syntax-highlighting.sh

source ~/.zplug/init.zsh

zplug "dracula/zsh", as:theme
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

eval "$(starship init zsh)"

