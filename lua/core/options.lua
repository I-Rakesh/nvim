vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.api.nvim_set_keymap(
	"n",
	"<Leader>cc",
	':let &colorcolumn = empty(&colorcolumn) ? "80" : ""<CR>',
	{ noremap = true, silent = true }
)

vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0

vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
