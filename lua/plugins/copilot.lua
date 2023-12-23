return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	keys = {
		{
			"<leader>cp",
			mode = "n",
			function()
				require("copilot.suggestion").toggle_auto_trigger()
			end,
			{ desc = "Toggle Copilot Suggestion" },
		},
	},
	-- dependencies = { "zbirenbaum/copilot-cmp" },
	config = function()
		local suggestion = require("copilot.suggestion")
		vim.keymap.set("n", "<leader>cp", suggestion.toggle_auto_trigger, { desc = "Toggle Copilot Suggestion" })
		require("copilot").setup({
			suggestion = {
				enabled = true,
				keymap = {
					accept = "<C-Space>",
					accept_word = "<C-w>",
					accept_line = "<C-l>",
				},
			},
			-- panel = { enabled = false },
			filetypes = {
				markdown = true,
				help = true,
			},
		})
		-- require("copilot_cmp").setup()
	end,
}
