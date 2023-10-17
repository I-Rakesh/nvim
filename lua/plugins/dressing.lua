return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	config = function()
		require("dressing").setup({
			input = {
				buf_options = {},
				win_options = {
					winblend = 0,
				},
			},
		})
	end,
}
