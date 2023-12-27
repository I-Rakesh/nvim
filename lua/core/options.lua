vim.g.mapleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.o.breakindent = true
vim.opt.wrap = false

vim.opt.swapfile = false

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0

vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

vim.opt.syntax = "ON"
vim.opt.mouse = "a"
vim.opt.backup = false
vim.opt.compatible = false

vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.virtualedit = "block"
vim.opt.inccommand = "split"

vim.opt.showmode = false

vim.cmd("highlight Pmenu guibg=NONE")
