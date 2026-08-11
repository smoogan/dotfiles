require("config.lazy")

require("mason").setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
})

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.list = true
vim.opt.listchars = "tab:>–,trail:+"

vim.opt.foldmethod = "indent"

vim.opt.colorcolumn = "81,121"

vim.opt.ignorecase = true

vim.opt.spelllang = "en_us"

vim.keymap.set('i', '{<CR>', '{<CR>}<Esc>O', { silent = true })

if vim.fn.executable('rg') == 1 then
    vim.opt.grepprg = 'rg --vimgrep'
end
