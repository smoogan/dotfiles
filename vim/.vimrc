call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-commentary'

Plug 'vim-syntastic/syntastic'

" Plug 'shawncplus/phpcomplete.vim'

Plug 'swekaj/php-foldexpr.vim'

Plug 'altercation/vim-colors-solarized'

Plug 'morhetz/gruvbox'

Plug 'junegunn/goyo.vim'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'scrooloose/nerdtree'

" Plug 'valloric/youcompleteme'
Plug 'ajh17/VimCompletesMe'

" Invoke with \\w for beginnings of words
Plug 'easymotion/vim-easymotion'

Plug 'nathanaelkane/vim-indent-guides'

Plug 'itchyny/lightline.vim'

Plug 'joonty/vdebug'

Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'saltstack/salt-vim'

call plug#end()

" Syntastic Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_php_checkers=["php"]
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:lightline = {'colorscheme': 'gruvbox'}

let g:lightline.active = {
    \ 'left': [ [ 'mode', 'paste' ],
    \           [ 'gitbranch' ],
    \           [ 'readonly', 'filename', 'modified' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'percent' ],
    \            [ 'fileformat', 'fileencoding', 'filetype' ] ] }
let g:lightline.inactive = {
    \ 'left': [ [ 'filename' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'percent' ] ] }
let g:lightline.tabline = {
    \ 'left': [ [ 'tabs' ] ],
    \ 'right': [ [ 'close' ] ] }
let g:lightline.component_function = {
    \ 'gitbranch': 'fugitive#head' }

" Solarized Settings
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_italic=0
let &t_Co = 256
set background=dark
" colorscheme solarized
colorscheme gruvbox
set guifont=DejaVu\ Sans\ Mono:h10

"CtrlP Settings
let g:ctrlp_lazy_update = 100
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 40000
let g:ctrlp_working_path_mode = 'rw'

" Indent Guides Settings
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_guide_size=1
let g:indent_guides_color_change_percent=90
" hi IndentGuidesOdd guibg=green ctermbg=Green
" hi IndentGuidesEven guibg=red ctermbg=3

" PHP Code Folding
" set foldmethod=expr
" let b:phpfold_heredocs = 1
" let b:phpfold_docblocks = 1
" let b:phpfold_doc_with_funcs = 0
" let b:phpfold_text_righ_lines = 1
" let b:phpfold_text_percent = 1

set grepprg=grep\ -IHnr
set hlsearch
set ignorecase
set rnu
set nu

imap <C-BS> <C-W>

set softtabstop=4
set shiftwidth=4
set expandtab

set splitbelow
set splitright

set colorcolumn=80
let &showbreak='> '

" File specific settings
" autocmd BufReadPost *.sls set syntax=yaml
" autocmd BufReadPost *.sls set filetype=yaml
" autocmd BufReadPost *.sls set filetype=yaml

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
augroup end

" let g:php_folding=2
" set foldmethod=syntax
set foldlevel=1

" GUI options
set mouse=a
set guioptions-=m "Remove menu bar"
set guioptions-=T "Remove toolbar"
set guioptions-=e "Disable GUI Tabs"
set guioptions-=r "Remove right-hand scroll bar"
set guioptions-=L "Remove left-hand scroll bar"

" Windows flags
if exists('+shellslash')
    " Use forward slash in windows
    set shellslash
endif
" Requires the DLL from: http://www.vim.org/scripts/script.php?script_id=2596
map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
