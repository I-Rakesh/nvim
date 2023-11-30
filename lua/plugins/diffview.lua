return {
	"sindrets/diffview.nvim",
	event = { "VeryLazy" },
	keys = {
		{ "<leader>dv", "<cmd>DiffviewOpen<CR>", desc = "DiffView" },
		{ "<leader>dcv", ":DiffviewOpen ", desc = "DiffView Specific File Commit" },
		{ "<leader>dh", "<cmd>DiffviewFileHistory %<CR>", desc = "DiffView Current File Histoyr" },
		{ "<leader>dbh", "<cmd>DiffviewFileHistory<CR>", desc = "DiffView Current Branch Histoyr" },
		{ "<leader>dn", "<cmd>DiffviewToggleFiles<CR>", desc = "DiffView File Tree" },
	},
	config = function() end,
}
