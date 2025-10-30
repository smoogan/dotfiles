if [ -d /usr/share/fzf ]; then
    source /usr/share/fzf/completion.bash
    source /usr/share/fzf/key-bindings.bash
elif [ -d /usr/share/doc/fzf ]; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
fi
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

alias ls='ls --group-directories-first --color=auto --indicator-style=slash'
alias ..="cd .."
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less
alias ll='ls -lh'
alias la='ls -Alh'
alias gs='git status'
alias gd='git diff'
alias gdt='git difftool'
alias gl='git log'
alias gf='git fetch'
alias gp='git pull'

shopt -s expand_aliases

export DOTNET_CLI_TELEMETRY_OPTOUT=1
export HISTSIZE=1000000
export HISTCONTROL=ignoreboth:erasedups
export EDITOR=/usr/bin/vim
export XDG_CONFIG_HOME=$HOME/.config

colors() {
    local fgc bgc vals seq0

    printf "Color escapes are %s\n" '\e[${value};...;${value}m'
    printf "Values 30..37 are \e[33mforeground colors\e[m\n"
    printf "Values 40..47 are \e[43mbackground colors\e[m\n"
    printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

    # foreground colors
    for fgc in {30..37}; do
        # background colors
        for bgc in {40..47}; do
            fgc=${fgc#37} # white
            bgc=${bgc#40} # black

            vals="${fgc:+$fgc;}${bgc}"
            vals=${vals%%;}

            seq0="${vals:+\e[${vals}m}"
            printf "  %-9s" "${seq0:-(default)}"
            printf " ${seq0}TEXT\e[m"
            printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
        done
        echo; echo
    done
}

