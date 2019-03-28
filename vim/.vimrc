scriptencoding utf-8
set nocompatible
set exrc

" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
let PLUG_DIRECTORY = "~/.vim/plugged"
source ~/.vim/baseplugins.vim

call plug#begin(PLUG_DIRECTORY)

call Load_base_plugins(PLUG_DIRECTORY)

" Haskell support
Plug 'eagletmt/neco-ghc'
Plug 'eagletmt/ghcmod-vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'neovimhaskell/haskell-vim'

call plug#end()

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" LightLine Settings
let g:lightline = {'colorscheme': 'gruvbox'}
let g:lightline.active = {
    \ 'left': [ [ 'mode', 'paste' ],
    \           [ 'gitbranch'],
    \           [ 'readonly', 'filename', 'modified' ] ],
    \ 'right': [ [ 'percent', 'lineinfo' ],
    \            [ 'fileformat', 'fileencoding', 'filetype' ],
    \            [ 'syntastic'] ] }
let g:lightline.inactive = {
    \ 'left': [ [ 'filename', 'modified'] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'percent' ] ] }
let g:lightline.tabline = {
    \ 'left': [ [ 'tabs' ] ],
    \ 'right': [ [ 'close' ] ] }
let g:lightline.component_function = {
    \ 'gitbranch': 'GitBranchTrimmed' }
function! GitBranchTrimmed()
    let gitbranch = fugitive#head()
    return gitbranch
    let pattern = '\w\{1,}/\w\{1,}-\d\{1,}'
    return matchstr(gitbranch, pattern)
endfun
set noshowmode


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

let g:gitgutter_diff_args = '-w'

"CtrlP Settings
let g:ctrlp_lazy_update = 100
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_root_markers = ['.gita']
" If file is open in buffer on another tab, open a new buffer with the file
let g:ctrlp_switch_buffer = 'et'
" if executable('bash')
"     let g:ctrlp_user_command = 'bash -c ag %s -l --nocolor -g ""'
" endif

" Indent Guides Settings
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_guide_size=1
let g:indent_guides_color_change_percent=90

set foldmethod=expr
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

" TAB mappings
" noremap tn :tabedit
" noremap tk :tabnext<CR>
" noremap tj :tabprevious<CR>
" noremap th :tabfirst<CR>
" noremap tl :tablast<CR>

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

set equalalways
set splitbelow
set splitright

set colorcolumn=81,121
let &showbreak='> '

" Only support unix file formats (will cause dos endings to be displayed)
" Use `set fileformat=unix` to convert the file
set fileformats=unix

" When pressing 'O' or 'o' on a commented line, don't automatically add
" comments (this is an autocmd because of of the c plugin for vim)
autocmd BufNewFile,BufRead * setlocal formatoptions-=o

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

set secure
