DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# VIM
mkdir --parents $HOME/.vim/php/
mkdir --parents $HOME/.vim/csharp/
ln --force --symbolic $DIR/vim/.vimrc $HOME/.vimrc
ln --force --symbolic $DIR/vim/baseplugins.vim $HOME/.vim/baseplugins.vim
ln --force --symbolic $DIR/vim/php/php.vim $HOME/.vim/php/php.vim
ln --force --symbolic $DIR/vim/csharp/csharp.vim $HOME/.vim/csharp/csharp.vim
ln --force --symbolic $DIR/vim/csharp/omnisharpMappings.vim $HOME/.vim/csharp/omnisharpMappings.vim

# i3wm
ln --force --symbolic $DIR/i3/i3blocks.conf $HOME/.config/i3/i3blocks.conf
ln --force --symbolic $DIR/i3/config $HOME/.config/i3/config

# tmux
ln --force --symbolic $DIR/tmux/.tmux.conf $HOME/.tmux.conf
