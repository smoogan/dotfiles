scriptencoding utf-8

" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
let PLUG_DIRECTORY = "~/.vim/plugged"
source ~/.vimrc

call plug#begin(PLUG_DIRECTORY."/csharp")

call Load_base_plugins(PLUG_DIRECTORY)

" Haskell support
Plug 'eagletmt/neco-ghc'
Plug 'eagletmt/ghcmod-vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'neovimhaskell/haskell-vim'

call plug#end()

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:ycm_semantic_triggers = {'haskell' : ['.']}
let $PATH .= (":" . $HOME . "/.cabal/bin" . ":" . $HOME . "/.local/bin")

autocmd BufWritePost *.hs :GhcModCheckAndLintAsync
