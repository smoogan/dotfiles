call plug#begin()
    Plug 'vim-scripts/Decho'

    Plug 'tpope/vim-sensible'

    Plug 'tpope/vim-surround',
    Plug 'tpope/vim-repeat',

    Plug 'morhetz/gruvbox'

    Plug 'itchyny/lightline.vim',
    Plug 'tpope/vim-fugitive',
    " Plug 'airblade/vim-gitgutter',

    Plug 'tpope/vim-commentary'
    " Invoke with \\w for beginnings of words
    Plug 'easymotion/vim-easymotion'

    Plug 'scrooloose/nerdtree'

    Plug 'ctrlpvim/ctrlp.vim'

    Plug 'autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                     \ 'do': 'bash install.sh',
                     \ }

     " (Optional) Multi-entry selection UI.
     Plug 'junegunn/fzf'

     Plug 'ionide/Ionide-vim', {
                 \ 'do':  'make fsautocomplete',
                 \ }
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
let &showbreak='> '

set foldmethod=indent
set foldlevel=4

set mouse=a
set hlsearch
set ignorecase

let g:gruvbox_italic=1
let g:gruvbox_bold=1
let g:gruvbox_invert_selection=0
set background=dark
colorscheme gruvbox

noremap : ;
noremap ; :

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

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


" LanguageClient/Ionide changes needed for NerdFont
let g:LanguageClient_diagnosticsDisplay = {
    \ 1: {
    \     "name": "Error",
    \     "texthl": "ALEError",
    \     "signText": "",
    \     "signTexthl": "ALEErrorSign",
    \ },
    \ 2: {
    \     "name": "Warning",
    \     "texthl": "ALEWarning",
    \     "signText": "",
    \     "signTexthl": "ALEWarningSign",
    \ },
    \ 3: {
    \     "name": "Information",
    \     "texthl": "ALEInfo",
    \     "signText": "",
    \     "signTexthl": "ALEInfoSign",
    \ },
    \ 4: {
    \     "name": "Hint",
    \     "texthl": "ALEInfo",
    \     "signText": "➤",
    \     "signTexthl": "ALEInfoSign",
    \ },
    \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> gk :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gi :call LanguageClient#explainErrorAtPoint()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" GUI options
set guioptions-=m "Remove menu bar"
set guioptions-=T "Remove toolbar"
set guioptions-=e "Disable GUI Tabs"
set guioptions-=r "Remove right-hand scroll bar"
set guioptions-=L "Remove left-hand scroll bar"
if exists('+guifont')
    set guifont=DejaVu\ Sans\ Mono:h10
endif


" Windows specific
if exists('+shellslash')
    " Use forward slash in windows
    set shellslash
endif


set secure
