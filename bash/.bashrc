# REQUIRES: bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set the prompt. It starts with the FTCS_PROMPT sequence (`\e]133;A\e\\`)
# which allows tmux to move between shell prompts.
PS1='\[\e]133;A\e\\\]\[\e[1;36m\]\u\[\e[1;90m\]@\[\e[1;35m\]\h \[\e[1;90m\]\W \$\[\e[m\] '

alias ls='ls --color=auto'
alias ip='ip --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# Enable extended tab completion.
# REQUIRES: bash-completion
if [[ -r /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
fi

shopt -s histappend
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Use the `lfub` and `lfcd` wrappers for `lf`
lfcd() {
    type lfub &>/dev/null && cmd="lfub" || cmd="lf"
    cd "$(command "$cmd" -print-last-dir "$@")"
}
export -f lfcd
alias lf='lfcd'

# Configure fzf
if type fzf &> /dev/null; then
    inputrc_path="$XDG_CONFIG_HOME/readline/inputrc"
    if [[ -f "$inputrc_path" ]]; then
        mode="$(\
            grep 'set editing-mode' "$inputrc_path" \
            | awk 'NF>1 { print $NF }'\
        )"
        if [[ -n "$mode" ]]; then
            set -o "$mode"
        fi
    fi
    eval "$(fzf --bash)"
    export FZF_DEFAULT_OPTS='--color=border:white'
fi

# vim:ts=4:sts=4:sw=4:et:
