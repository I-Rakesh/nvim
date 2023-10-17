return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = "VeryLazy",
	config = function()
		vim.cmd([[highlight IndentBlanklineIndent1 guifg=#403b3c gui=nocombine]])

		vim.opt.listchars:append("space:⋅")

		require("ibl").setup({
			indent = { char = "┊" },
			scope = { enabled = false },
		})
	end,
}
