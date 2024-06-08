vim.g.mapleader = " "
vim.opt.guicursor = ""

vim.opt.fillchars = { eob = " " } -- to remove "~" at end of the file

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.cmdheight = 0
vim.opt.diffopt = vim.list_extend(vim.opt.diffopt:get(), { "algorithm:histogram", "linematch:60" })

vim.opt.confirm = true -- confirm to save changes before exiting modified buffer

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.o.breakindent = true
vim.opt.wrap = false

vim.opt.swapfile = false

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 250

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

-- vim.opt.showmode = false

vim.opt.pumheight = 10 --to set the limit for cmp-window

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
