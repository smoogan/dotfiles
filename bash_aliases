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

export DOTNET_CLI_TELEMETRY_OPTOUT=1
export HISTSIZE=1000000
export HISTCONTROL=ignoreboth:erasedups
export EDITOR=/usr/bin/vim
export XDG_CONFIG_HOME=$HOME/.config
