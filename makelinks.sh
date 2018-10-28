DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# VIM
ln -fs $DIR/vim/.vimrc $HOME/.vimrc

# i3wm (sudo apt install i3-wm i3blocks rofi)
mkdir -p ~/.fonts
SanFranName="SystemSanFransiscoDisplayRegular"
if [[ ! -f ~/.fonts/$SanFranName.ttf ]]; then
    SanFranUrl="https://github.com/supermarin/YosemiteSanFranciscoFont/raw/master/System%20San%20Francisco%20Display%20Regular.ttf"
    curl --output ~/.fonts/$SanFranName.ttf $SanFranUrl
fi

FontawesomeName="fontawesome-free-5.4.2-desktop"
if [[ ! -d ~/.fonts/fontawesome-free-5.4.2-desktop ]]; then
    FontAwesomeUrl="https://use.fontawesome.com/releases/v5.4.2/fontawesome-free-5.4.2-desktop.zip"
    TempDir=`mktemp -d`
    echo $TempDir

    curl --output $TempDir/$FontawesomeName.zip $FontAwesomeUrl
    unzip -oq $TempDir/$FontawesomeName.zip -d $TempDir
    mv $TempDir/$FontawesomeName ~/.fonts/
    rm -f $TempDir/$FontawesomeName.zip
    rm -r $TempDir
fi
ln -fs $DIR/i3/i3blocks.conf $HOME/.config/i3/i3blocks.conf
ln -fs $DIR/i3/config $HOME/.config/i3/config

# tmux
ln -fs $DIR/tmux/.tmux.conf $HOME/.tmux.conf
