#
# ~/.bashrc
#

[[ $- != *i* ]] && return

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

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
    xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
        ;;
    screen*)
        PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
        ;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
    && type -P dircolors >/dev/null \
    && match_lhs=$(dircolors --print-database)
    [[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

    if ${use_color} ; then
        # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
        if type -P dircolors >/dev/null ; then
            if [[ -f ~/.dir_colors ]] ; then
                eval $(dircolors -b ~/.dir_colors)
            elif [[ -f /etc/DIR_COLORS ]] ; then
                eval $(dircolors -b /etc/DIR_COLORS)
            fi
        fi

        if [[ ${EUID} == 0 ]] ; then
            PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
        else
            PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
        fi

        alias ls='ls --group-directories-first --color=auto --indicator-style=slash'
        alias grep='grep --colour=auto'
        alias egrep='egrep --colour=auto'
        alias fgrep='fgrep --colour=auto'
    else
        if [[ ${EUID} == 0 ]] ; then
            # show root@ when we don't have colors
            PS1='\u@\h \W \$ '
        else
            PS1='\u@\h \w \$ '
        fi
    fi

    unset use_color safe_term match_lhs sh

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
    alias gd='git difftool'
    alias gl='git log'
    alias gf='git fetch'
    alias gp='git pull'

    xhost +local:root > /dev/null 2>&1

    complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1   ;;
            *.tar.gz)    tar xzf $1   ;;
            *.bz2)       bunzip2 $1   ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1    ;;
            *.tar)       tar xf $1    ;;
            *.tbz2)      tar xjf $1   ;;
            *.tgz)       tar xzf $1   ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1;;
            *.7z)        7z x $1      ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

if [ -d /usr/share/fzf ]; then
    source /usr/share/fzf/completion.bash
    source /usr/share/fzf/key-bindings.bash
elif [ -d /usr/share/doc/fzf ]; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
fi
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export HISTSIZE=1000000
export HISTCONTROL=ignoreboth:erasedups
export EDITOR=/usr/bin/vim
export XDG_CONFIG_HOME=$HOME/.config
export EXERCISM_CONFIG_HOME=$HOME/snap/exercism/5/.config/exercism

# .NET Settings
export DOTNET_CLI_TELEMETRY_OPTOUT=1
PATH=$PATH:$HOME/.dotnet/tools/

# Note: Bash on Windows does not currently apply umask properly.
if [ "$(umask)" = "0000" ]; then
    umask 022
fi
