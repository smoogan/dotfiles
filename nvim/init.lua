require("config.lazy")

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.list = true
vim.opt.listchars = "tab:>–,trail:+"

vim.opt.colorcolumn = "81,121"

vim.opt.ignorecase = true

vim.opt.spelllang = "en_us"

vim.keymap.set('i', '{<CR>', '{<CR>}<Esc>O', { silent = true })
