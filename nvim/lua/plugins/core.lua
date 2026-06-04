return {
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            background = "light"
        },
        config = function()
            require("gruvbox").setup({
            })
            vim.cmd([[colorscheme gruvbox]])
        end,
    },
    {
        "kylechui/nvim-surround",
    },
    {
        "easymotion/vim-easymotion",
    },
    {
        "preservim/nerdtree",
    },
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    }
}
