return {
	"folke/trouble.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		vim.keymap.set("n", "<leader>t;", function()
			require("trouble").toggle()
		end, { desc = "Toggle Trouble" })
		vim.keymap.set("n", "<leader>tw", function()
			require("trouble").toggle("workspace_diagnostics")
		end, { desc = "Toggle Trouble (Workspace Diagnostics)" })
		vim.keymap.set("n", "<leader>td", function()
			require("trouble").toggle("document_diagnostics")
		end, { desc = "Toggle Trouble (Document Diagnostics)" })
		vim.keymap.set("n", "<leader>tq", function()
			require("trouble").toggle("quickfix")
		end, { desc = "Toggle Trouble (Quickfix List)" })
		vim.keymap.set("n", "<leader>tl", function()
			require("trouble").toggle("loclist")
		end, { desc = "Toggle Trouble (Location List)" })
		vim.keymap.set("n", "<leader>tr", function()
			require("trouble").toggle("lsp_references")
		end, { desc = "Toggle Trouble (LSP References)" })
		vim.keymap.set("n", "]t", function()
			require("trouble").next({ skip_groups = true, jump = true })
		end, { desc = "Next Trouble Item (Skip Groups, Jump)" })
		vim.keymap.set("n", "[t", function()
			require("trouble").previous({ skip_groups = true, jump = true })
		end, { desc = "Previous Trouble Item (Skip Groups, Jump)" })
	end,
}
