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
        "mason-org/mason.nvim",
        opts = {}
    },
}
