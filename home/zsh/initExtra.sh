setopt PROMPT_SUBST

alias trim="sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'"

function emoji() {
    local int=$(shuf -i 1-100 -n 1)
    if [ $int -gt "99" ]; then; echo -n "🏳️‍⚧️"
    elif [ $int -gt "90" ]; then; echo -n "🦀"
    else; echo -n "🦦"
    fi
}

function prompt() {
    local P=$(pwd | sed -E "s/\\/home\\/[a-z]*/~/" | sed -E "s/~$//" | sed -E "s/\n//")
    local G=$(grompt)
    local left="%{\033[1;33m%}"$P"%{\033[0m%} $G "
    local T=$(echo $left | trim)
    print $T" "$(emoji)" "
}

export PS1='$(prompt)'
export DIRENV_LOG_FORMAT=""



# set cursor to line
echo '\e[5 q'

# keybinds
bindkey '^H' backward-kill-word
bindkey '5~' kill-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

autoload -U compinit
compinit -i
setopt complete_in_word
setopt always_to_end
