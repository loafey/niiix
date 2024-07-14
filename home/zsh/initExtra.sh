setopt PROMPT_SUBST

alias trim="sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'"
function fancyPrompt() {
    local promptesc=$(print -rP $(rrompt) | sed -n 'l 1000')
    local prompty=${promptesc::-1}
    print $(sed 's/\\033\[[0-9;]*m/%{\0%}/g' <<< $prompty)
}

export PS1=' $(fancyPrompt) '
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
setopt prompt_subst
