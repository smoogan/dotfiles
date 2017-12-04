DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# VIM
ln -fs $DIR/vim/.vimrc $HOME/.vimrc

# i3wm
ln -fs $DIR/i3/i3blocks.conf $HOME/.config/i3/i3blocks.conf
ln -fs $DIR/i3/config $HOME/.config/i3/config

# tmux
ln -fs $DIR/tmux/.tmux.conf $HOME/.tmux.conf
