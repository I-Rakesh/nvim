return {
	"nvim-tree/nvim-tree.lua",
	cmd = "NvimTreeToggle",
	keys = {
		{ "<c-n>", mode = { "n" }, "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Open File Tee" } },
	},
	config = function()
		require("nvim-tree").setup({
			view = {
				adaptive_size = true,
			},
			filters = {
				dotfiles = true,
			},
		})
	end,
}
