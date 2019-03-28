function! Load_base_plugins(PLUG_DIRECTORY)
    let BASE_PLUGIN_DIRECTORY= a:PLUG_DIRECTORY."/base"
    Plug 'liuchengxu/vim-which-key',
                \ {'dir': BASE_PLUGIN_DIRECTORY.'/vim-which-key'}

    Plug 'tpope/vim-sensible',
                \ {'dir': BASE_PLUGIN_DIRECTORY.'/vim-sensible'}
    Plug 'tpope/vim-surround',
                \ {'dir': BASE_PLUGIN_DIRECTORY.'/vim-surround'}
    Plug 'tpope/vim-repeat',
                \ {'dir': BASE_PLUGIN_DIRECTORY.'/vim-repeat'}

    Plug 'morhetz/gruvbox',
                \ {'dir': BASE_PLUGIN_DIRECTORY.'/gruvbox'}

    Plug 'itchyny/lightline.vim',
                \ {'dir': BASE_PLUGIN_DIRECTORY.'/lightline.vim'}
    Plug 'tpope/vim-fugitive',
                \ {'dir': BASE_PLUGIN_DIRECTORY.'/vim-fugitive'}
    Plug 'airblade/vim-gitgutter',
                \ {'dir': BASE_PLUGIN_DIRECTORY.'/vim-gitgutter'}

    Plug 'tpope/vim-commentary',
                \ {'dir': BASE_PLUGIN_DIRECTORY.'/vim-commentary'}
    " Invoke with \\w for beginnings of words
    Plug 'easymotion/vim-easymotion',
                \ {'dir': BASE_PLUGIN_DIRECTORY.'/vim-easymotion'}

    Plug 'nathanaelkane/vim-indent-guides',
                \ {'dir': BASE_PLUGIN_DIRECTORY.'/vim-indent-guides'}

    Plug 'scrooloose/nerdtree',
                \ {'dir': BASE_PLUGIN_DIRECTORY.'/nerdtree'}

    Plug 'ctrlpvim/ctrlp.vim',
                \ {'dir': BASE_PLUGIN_DIRECTORY.'/ctrlp.vim'}

    Plug 'junegunn/goyo.vim',
                \ {'dir': BASE_PLUGIN_DIRECTORY.'/goyo.vim'}

    Plug 'majutsushi/tagbar',
                \ {'dir': BASE_PLUGIN_DIRECTORY.'/tagbar'}

endfunction
