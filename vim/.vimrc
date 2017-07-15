call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'

Plug 'tpope/vim-fugitive'

Plug 'shawncplus/phpcomplete.vim'

Plug 'altercation/vim-colors-solarized'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'scrooloose/nerdtree'

Plug 'valloric/youcompleteme'

" Invoke with \\w for beginnings of words
Plug 'easymotion/vim-easymotion'

Plug 'nathanaelkane/vim-indent-guides'

Plug 'itchyny/lightline.vim'

Plug 'joonty/vdebug'

call plug#end()

" Solarized Settings
let g:solarized_termcolors=256
"set background=light
"colorscheme solarized
let &t_Co = 256
set background=dark
colorscheme solarized

" colorscheme molokai

" Indent Guides Settings
let g:indent_guides_guide_size=1
let g:indent_guides_color_change_percent=3
let g:indent_guides_on_vim_startup=1

set rnu
set nu

set softtabstop=4
set shiftwidth=4
set expandtab

set splitbelow
set splitright

set colorcolumn=80
let &showbreak='> '
