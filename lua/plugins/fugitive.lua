return {
	"tpope/vim-fugitive",
	event = "VeryLazy",
	config = function()
		vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git Status" })
		vim.keymap.set("n", "<leader>gD", ":Git difftool<CR>", { desc = "Git Difftool" })
		vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git Push" })
		vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git Commit" })
		vim.keymap.set("n", "<leader>gl", ":Git log<CR>", { desc = "Git Log" })
	end,
}
