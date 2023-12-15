return {
	"folke/trouble.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		vim.keymap.set("n", "<leader>qt", function()
			require("trouble").toggle()
		end, { desc = "Toggle Trouble" })
		vim.keymap.set("n", "<leader>qw", function()
			require("trouble").toggle("workspace_diagnostics")
		end, { desc = "Toggle Trouble (Workspace Diagnostics)" })
		vim.keymap.set("n", "<leader>qd", function()
			require("trouble").toggle("document_diagnostics")
		end, { desc = "Toggle Trouble (Document Diagnostics)" })
		vim.keymap.set("n", "<leader>qq", function()
			require("trouble").toggle("quickfix")
		end, { desc = "Toggle Trouble (Quickfix List)" })
		vim.keymap.set("n", "<leader>ql", function()
			require("trouble").toggle("loclist")
		end, { desc = "Toggle Trouble (Location List)" })
		vim.keymap.set("n", "<leader>qr", function()
			require("trouble").toggle("lsp_references")
		end, { desc = "Toggle Trouble (LSP References)" })
		vim.keymap.set("n", "]q", function()
			require("trouble").next({ skip_groups = true, jump = true })
		end, { desc = "Next Trouble Item (Skip Groups, Jump)" })
		vim.keymap.set("n", "[q", function()
			require("trouble").previous({ skip_groups = true, jump = true })
		end, { desc = "Previous Trouble Item (Skip Groups, Jump)" })
	end,
}
