setopt PROMPT_SUBST

alias trim="sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'"
function fancyPrompt() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        print "%~ $(grompt) 🚀"
    else
        local promptesc=$(print -rP $(rrompt))
        print $(sed 's/\\033\[[0-9;]*m/%{\0%}/g' <<< $promptesc)
    fi
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

bindkey '^[[A' history-substring-search-up # or '\eOA'
bindkey '^[[B' history-substring-search-down # or '\eOB'
export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
export PATH=$PATH:~/.cargo/bin/
