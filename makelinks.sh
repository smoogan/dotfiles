#!/usr/bin/env bash
function helptext()
{
cat << EOF
This script takes the configuration files in this repository and creates symbolic
links to their required locations.
Valid options:
    - vim
    - tmux
    - i3
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
        tmux) tmux=true ;;
        *)
            echo "$BASH_SOURCE: invalid argument '$ARG'"
            helptext
            exit 2
    esac
done

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# VIM
if [ $vim ]; then
    mkdir --parents $HOME/.vim/php/
    mkdir --parents $HOME/.vim/csharp/
    ln --force --symbolic $DIR/vim/.vimrc $HOME/.vimrc
    ln --force --symbolic $DIR/vim/baseplugins.vim $HOME/.vim/baseplugins.vim
    ln --force --symbolic $DIR/vim/php/php.vim $HOME/.vim/php/php.vim
    ln --force --symbolic $DIR/vim/csharp/csharp.vim $HOME/.vim/csharp/csharp.vim
    ln --force --symbolic $DIR/vim/csharp/omnisharpMappings.vim $HOME/.vim/csharp/omnisharpMappings.vim
fi

# i3wm (sudo apt install i3-wm i3blocks rofi)
if [ $i3 ]; then
    mkdir --parents ~/.fonts
    SanFranName="SystemSanFransiscoDisplayRegular"
    if [[ ! -f ~/.fonts/$SanFranName.ttf ]]; then
        SanFranUrl="https://github.com/supermarin/YosemiteSanFranciscoFont/raw/master/System%20San%20Francisco%20Display%20Regular.ttf"
        curl --output ~/.fonts/$SanFranName.ttf $SanFranUrl
    fi

    FontawesomeName="fontawesome-free-5.4.2-desktop"
    if [[ ! -d ~/.fonts/fontawesome-free-5.4.2-desktop ]]; then
        FontAwesomeUrl="https://use.fontawesome.com/releases/v5.4.2/fontawesome-free-5.4.2-desktop.zip"
        TempDir=`mktemp --directory`
        echo $TempDir

        curl --output $TempDir/$FontawesomeName.zip $FontAwesomeUrl
        unzip -oq $TempDir/$FontawesomeName.zip -d $TempDir
        mv $TempDir/$FontawesomeName ~/.fonts/
        rm -f $TempDir/$FontawesomeName.zip
        rm -r $TempDir
    fi
    ln --force --symbolic $DIR/i3/i3blocks.conf $HOME/.config/i3/i3blocks.conf
    ln --force --symbolic $DIR/i3/config $HOME/.config/i3/config
fi

# tmux
if [ $tmux ]; then
    ln --force --symbolic $DIR/tmux/.tmux.conf $HOME/.tmux.conf
fi
