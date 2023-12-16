return {
	"tpope/vim-fugitive",
	keys = {
		{ "<leader>gs", mode = "n", vim.cmd.Git, { desc = "Git Status" } },
		{ "<leader>gD", mode = "n", ":Git difftool<CR>", { desc = "Git Difftool" } },
		{ "<leader>gp", mode = "n", ":Git push<CR>", { desc = "Git Push" } },
		{ "<leader>gc", mode = "n", ":Git commit<CR>", { desc = "Git Commit" } },
		{ "<leader>gl", mode = "n", ":Git log<CR>", { desc = "Git Log" } },
	},
}
