#!/usr/bin/env bash
function helptext()
{
cat << EOF
This script takes the configuration files in this repository and creates symbolic
links to their required locations.
Valid options:
    - vim
    - tmux
    - git
    - i3
    - fonts
    - bash
    - urxvt
    - vscode
Example: ./makeLinks.sh vim tmux
EOF
}

if [ "$#" -eq 0 ]; then
    echo "$BASH_SOURCE: missing required opperand"
    helptext
    exit 1
fi

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    helptext
    exit 0
fi

for ARG in "$@"; do
    case "$ARG" in
        vim) vim=true ;;
        i3) i3=true ;;
        fonts) fonts=true ;;
        tmux) tmux=true ;;
        git) git=true ;;
        bash) bash=true ;;
        urxvt) urxvt=true ;;
        vscode) vscode=true ;;
        *)
            echo "$BASH_SOURCE: invalid argument '$ARG'"
            helptext
            exit 2
    esac
done

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Git
if [ $git ]; then
    ln --force --symbolic $DIR/gitconfig $XDG_CONFIG_HOME/git/config

    read -p "Enter name for Git: " name
    read -p "Enter email for Git: " email

    echo "[user]" > $XDG_CONFIG_HOME/git/userConfig
    echo "    name = $name" >> $XDG_CONFIG_HOME/git/userConfig
    echo "    email = $email" >> $XDG_CONFIG_HOME/git/userConfig
fi

# VIM
if [ $vim ]; then
    if [ ! -f $HOME/.vim/autoload/plug.vim ]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
    ln --force --symbolic $DIR/vim/.vimrc $HOME/.vimrc
fi

# Fonts
if [ $fonts ]; then
    ln --force --symbolic $DIR/fonts $HOME/.fonts
fi

# i3wm (sudo apt install i3-wm i3blocks)
if [ $i3 ]; then
    ln --force --symbolic $DIR/i3/i3blocks.conf $HOME/.config/i3/i3blocks.conf
    ln --force --symbolic $DIR/i3/config $HOME/.config/i3/config
    ln --force --symbolic $DIR/i3/toggleDisplay.sh $HOME/.config/i3/toggleDisplay.sh

    if [ ! -d $HOME/.config/i3/i3blocks-scripts ]; then
        git clone https://github.com/vivien/i3blocks-contrib.git \
            $HOME/.config/i3/i3blocks-scripts
        make $HOME/.config/i3/i3blocks-scripts
    fi
fi

# tmux
if [ $tmux ]; then
    mkdir --parents $HOME/.config/tmux/
    ln --force --symbolic $DIR/tmux/tmux.conf $HOME/.config/tmux/tmux.conf
    # Needed until wider release of Tmux 3.2 (for XDG_CONFIG_HOME support)
    ln --force --symbolic $DIR/tmux/tmux.conf $HOME/.tmux.conf
fi

# bash
if [ $bash ]; then
    ln --force --symbolic $DIR/bash_aliases $HOME/.bash_aliases
    source $HOME/.bashrc
fi

# urxvt (requires rxvt-unicode)
if [ $urxvt ]; then
    ln --force --symbolic $DIR/.Xresources $HOME/.Xresources
    xrdb $HOME/.Xresources
fi

# VS Code
if [ $vscode ]; then
    ln --force --symbolic $DIR/vscode/settings.json $HOME/.config/Code/User/settings.json
fi
