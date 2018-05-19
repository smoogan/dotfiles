scriptencoding utf-8

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-commentary'

Plug 'vim-syntastic/syntastic'

Plug 'swekaj/php-foldexpr.vim'

Plug 'majutsushi/tagbar'

Plug 'morhetz/gruvbox'

Plug 'junegunn/goyo.vim'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'scrooloose/nerdtree'

Plug 'valloric/youcompleteme'
" Plug 'ajh17/VimCompletesMe'
" Plug 'shawncplus/phpcomplete.vim'

" Invoke with \\w for beginnings of words
Plug 'easymotion/vim-easymotion'

Plug 'nathanaelkane/vim-indent-guides'

Plug 'itchyny/lightline.vim'

Plug 'joonty/vdebug'

Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'saltstack/salt-vim'

" Haskell support
Plug 'eagletmt/neco-ghc'
Plug 'eagletmt/ghcmod-vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'neovimhaskell/haskell-vim'

call plug#end()

" Syntastic Settings
set statusline&
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_php_checkers=["php"]
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" LightLine Settings
let g:lightline = {'colorscheme': 'gruvbox'}
let g:lightline.active = {
    \ 'left': [ [ 'mode', 'paste' ],
    \           [ 'gitbranch' ],
    \           [ 'readonly', 'filename', 'modified' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'percent' ],
    \            [ 'fileformat', 'fileencoding', 'filetype' ] ] }
let g:lightline.inactive = {
    \ 'left': [ [ 'filename', 'modified' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'percent' ] ] }
let g:lightline.tabline = {
    \ 'left': [ [ 'tabs' ] ],
    \ 'right': [ [ 'close' ] ] }
let g:lightline.component_function = {
    \ 'gitbranch': 'GitBranchTrimmed' }

function! GitBranchTrimmed()
    let gitbranch = fugitive#head()
    let pattern = '\w\{1,}/\w\{1,}-\d\{1,}'
    return matchstr(gitbranch, pattern)
endfun

" ColorScheme Settings
if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes
    " work properly when Vim is used inside tmux, GNU screen, or WSL.
    set t_ut=
endif
let g:gruvbox_italic=1
let g:gruvbox_bold=1
let g:gruvbox_italicize_comments=0
let g:gruvbox_invert_selection=0
set background=dark
colorscheme gruvbox
if exists('+guifont')
    set guifont=DejaVu\ Sans\ Mono:h10
endif

" Tagbar config
" On linux use 'universal-ctags' for PHP support
if filereadable('C:/Program Files (x86)/Vim/ctags/ctags.exe')
    let g:tagbar_ctags_bin = 'C:/Program Files (x86)/Vim/ctags/ctags.exe'
elseif executable('unictags')
    let g:tagbar_ctags_bin = 'unictags'
endif
highlight! link TagbarVisibilityPublic GruvboxGreen
highlight! link TagbarVisibilityProtected GruvboxBlue
highlight! link TagbarVisibilityPrivate GruvboxRed


let g:gitgutter_diff_args = '-w'

"CtrlP Settings
let g:ctrlp_lazy_update = 100
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0
let g:ctrlp_working_path_mode = 'rw'
" If file is open in buffer on another tab, open a new buffer with the file
let g:ctrlp_switch_buffer = 'et'
" if executable('bash')
"     let g:ctrlp_user_command = 'bash -c ag %s -l --nocolor -g ""'
" endif

" Indent Guides Settings
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_guide_size=1
let g:indent_guides_color_change_percent=90

let g:vdebug_options = {}

" PHP Code Folding
set foldmethod=expr
let g:phpfold_heredocs = 1
let g:phpfold_docblocks = 1
let g:phpfold_doc_with_funcs = 0
let g:phpfold_text_right_lines = 1
let g:phpfold_text_percent = 1
set foldmethod=indent
set foldlevel=4

" Setting this to an empty array so we can set project specific values

let g:goyo_height="100%"

set grepprg=grep\ -IHnr
set ignorecase
set rnu
set nu

set hlsearch

map! <C-BS> <C-W>

noremap : ;
noremap ; :

set softtabstop=4
set shiftwidth=4
set expandtab
set list
set listchars=tab:>–,trail:+

inoremap {<CR> {<CR>}<Esc>O
" <82> = Ctrl + Shift + b
" <8e> = Ctrl + Shift + n
noremap  :NERDTreeToggle<CR><C-W>=
noremap  :NERDTreeFind<CR><C-W>=
" <94> = Ctrl + Shift + t
noremap  :TagbarToggle<CR><C-W>=

set splitbelow
set splitright

set colorcolumn=80
let &showbreak='> '

" Only support unix file formats (will cause dos endings to be displayed)
" Use `set fileformat=unix` to convert the file
set fileformats=unix
" When pressing 'O' or 'o' on a commented line, don't automatically add
" comments (this is an autocmd because of of the c plugin for vim)
autocmd BufNewFile,BufRead * setlocal formatoptions-=o

" File specific settings
autocmd BufReadPost *.sls set syntax=yaml
autocmd BufReadPost *.sls set filetype=yaml

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
"  (won't do anything in neovim)
if exists('+libcall')
    map <F11> <Esc>;call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
endif


" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:ycm_semantic_triggers = {'haskell' : ['.']}
let $PATH .= (":" . $HOME . "/.cabal/bin" . ":" . $HOME . "/.local/bin")

autocmd BufWritePost *.hs :GhcModCheckAndLintAsync
