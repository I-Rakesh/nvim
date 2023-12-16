return {
	"CRAG666/code_runner.nvim",
	keys = {
		{ "<leader>rr", mode = "n", ":RunProject<CR>", desc = "Run Project" },
		{ "<leader>rx", mode = "n", ":RunClose<CR>", desc = "Run Close" },
		{ "<leader>rcf", mode = "n", ":CRFiletype<CR>" },
		{ "<leader>rcp", mode = "n", ":CRProjects<CR>" },
		{ "<leader>rr", mode = "n", ":RunFile term<CR>", desc = "Run Code In Horzantle Split" },
		{ "<leader>rf", mode = "n", ":RunFile float<CR>", desc = "Run Code In Float" },
		{ "<leader>rt", mode = "n", ":RunFile tab<CR>", desc = "Run Code In Tab" },
	},
	config = function()
		require("code_runner").setup({
			filetype = {
				java = {
					"cd $dir &&",
					"javac $fileName &&",
					"java $fileNameWithoutExt",
				},
				python = "python3 -u",
				typescript = "deno run",
				rust = {
					"cd $dir &&",
					"rustc $fileName &&",
					"$dir/$fileNameWithoutExt",
				},
				c = {
					"cd $dir &&",
					"gcc -o $fileNameWithoutExt $fileName &&",
					"$dir/$fileNameWithoutExt",
				},
				cpp = {
					"cd $dir &&",
					"g++ -o $fileNameWithoutExt $fileName &&",
					"$dir/$fileNameWithoutExt",
				},
				html = {
					"cd $dir &&",
					"open $fileName",
				},
				sh = {
					"cd $dir &&",
					"chmod +x $fileName &&",
					"./$fileName",
				},
			},
			mode = "float",
			float = {
				border = "single",
				height = 0.5,
				width = 0.5,
				x = 0.5,
				y = 0.5,
				border_hl = "Normal",
			},
		})
	end,
}
