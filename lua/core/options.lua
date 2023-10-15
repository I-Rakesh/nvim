vim.g.mapleader = " "

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.o.breakindent = true
vim.opt.wrap = false

vim.o.undofile = true

vim.opt.swapfile = false

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.api.nvim_set_keymap(
  "n",
  "<Leader>cc",
  ':let &colorcolumn = empty(&colorcolumn) ? "80" : ""<CR>',
  { noremap = true, silent = true }
)

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
