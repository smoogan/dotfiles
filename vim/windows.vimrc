source $VIM/_vimrc

call plug#begin()

    Plug 'tpope/vim-sensible'

    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'

    Plug 'easymotion/vim-easymotion'

    Plug 'ctrlpvim/ctrlp.vim'

    Plug 'morhetz/gruvbox'

call plug#end()

set relativenumber
set number

set splitbelow
set splitright

set softtabstop=4
set shiftwidth=4
set expandtab

set list
set listchars=tab:>–,trail:+

set linebreak
set colorcolumn=81,121
let &showbreak='>> '

set cul

set foldmethod=indent
set foldlevel=4

set mouse=a
set hlsearch
set ignorecase

set spelllang=en_us


""""""""""""""""""""""""
" ColorScheme Settings
""""""""""""""""""""""""
set termguicolors
let g:gruvbox_italic=1
let g:gruvbox_bold=1
let g:gruvbox_invert_selection=0
let g:gruvbox_guisp_fallback='bg'
set background=dark
colorscheme gruvbox

""""""""""""
" Functions
""""""""""""

" noremap : ;
" noremap ; :

inoremap {<CR> {<CR>}<Esc>O

" Remove trailing whitespace on save and restore cursor to last position
function! <SID>StripTrailingWhitespace()
    let saved_cursor = getcurpos()
    %s/\s\+$//e
    call setpos('.', saved_cursor)
endfun
function! <SID>StripTrailingNewLines()
    let saved_cursor = getcurpos()
    %s/\($\n\s*\)\+\%$//e
    call setpos('.', saved_cursor)
endfun
augroup whitespacefix
    autocmd! BufWritePre
    autocmd BufWritePre * :call <SID>StripTrailingWhitespace()
    autocmd BufWritePre * :call <SID>StripTrailingNewLines()
    autocmd BufWritePre *.php :retab
augroup end

autocmd InsertEnter,InsertLeave * set cul!
if &term =~ 'rxvt'
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[4 q"
    let &t_EI = "\<Esc>[2 q"
endif
if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes
    " work properly when Vim is used inside tmux, GNU screen, or WSL.
    set t_ut=
endif

" When pressing 'O' or 'o' on a commented line, don't automatically add
" comments (this is an autocmd because of of the c plugin for vim)
autocmd BufNewFile,BufRead * setlocal formatoptions-=o


" Custom filetypes
au BufRead,BufNewFile *.lookml set filetype=yaml
au BufRead,BufNewFile *.md setlocal spell



" Windows specific
if exists('+shellslash')
    " Use forward slash in windows
    set shellslash
endif



set secure
