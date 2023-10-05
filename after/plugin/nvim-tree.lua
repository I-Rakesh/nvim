vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.termguicolors = true
require("nvim-tree").setup({
	view = {
		adaptive_size = true,
	},
	filters = {
		dotfiles = true,
	},
})

vim.keymap.set("n", "<c-n>", ":NvimTreeFindFileToggle<CR>")
