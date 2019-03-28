scriptencoding utf-8

" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
let PLUG_DIRECTORY = "~/.vim/plugged"
source ~/.vimrc

call plug#begin(PLUG_DIRECTORY."/php")

call Load_base_plugins(PLUG_DIRECTORY)

Plug 'vim-syntastic/syntastic'

""" Client  Plugins
Plug 'vim-vdebug/vdebug', {'for': 'php'}
Plug 'Glench/Vim-Jinja2-Syntax', {'for': 'sls'}
Plug 'saltstack/salt-vim', {'for': 'sls'}
Plug 'lukevers/php-foldexpr.vim', {'for': 'php'}


call plug#end()

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" Syntastic Settings
let g:syntastic_php_checkers=["php", "phpmd", "phpcs"]
let g:syntastic_php_phpmd_post_args = ["phpmdruleset.xml"]
let g:syntastic_php_phpcs_args = ["--standard=~/moodle-local_codechecker/moodle"]
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_sort_aggregated_errors = 0
let g:syntastic_loc_list_height = 5
let g:syntastic_stl_format = 'Issues: %t (%w/%e)]'
let g:syntastic_auto_loc_list = 2 " Open manually, close automatically
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_highlighting = 0 " causes slowness

" to speed up navigation
let g:syntastic_cursor_columns = 0
let g:syntastic_enable_signs = 0

" Syntastic Lightline component
let g:lightline.component_expand = {
    \ 'syntastic': 'SyntasticStatuslineFlag' }
let g:lightline.component_type = {
    \ 'syntastic': 'error' }
let g:syntastic_mode_map = { 'mode': 'passive' }
augroup AutoSyntastic
    autocmd!
    autocmd BufWritePost *.php call s:syntastic()
    autocmd BufReadPost *.php call s:syntastic()
augroup END
function! s:syntastic()
    " Only alert me to PHP syntax errors. PHPcs and PHPmd run in background
    SyntasticCheck php
    let l:php_errors = len(g:SyntasticLoclist.current().errors())
    if (l:php_errors > 0)
        Errors
    else
        SyntasticCheck phpcs phpmd
    endif
    call lightline#update()
endfunction
set noshowmode

" VDebug
let g:vdebug_options = {}
let g:vdebug_options.path_maps = {"/institutesRoot/moodle/": "/mnt/c/Users/smoogan/Documents/institutesRoot/moodle/"}
let g:vdebug_options.break_on_open = 0
let g:vdebug_options.watch_window_style = 'compact'

" PHP Code Folding
let g:phpfold_heredocs = 1
let g:phpfold_docblocks = 1
let g:phpfold_doc_with_funcs = 1
let g:phpfold_text_right_lines = 1
let g:phpfold_text_percent = 1

" File specific settings
autocmd BufReadPost *.sls set syntax=yaml
autocmd BufReadPost *.sls set filetype=yaml
