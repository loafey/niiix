setopt PROMPT_SUBST

alias trim="sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'"

export PS1='$(rrompt) '
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
