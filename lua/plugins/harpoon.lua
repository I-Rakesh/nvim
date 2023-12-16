return {
	"ThePrimeagen/harpoon",
	keys = {
		{
			"<leader>a",
			mode = "n",
			function()
				require("harpoon.mark").add_file()
			end,
			desc = "Harpoon Mark",
		},
		{
			"<leader>sh",
			mode = "n",
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			desc = "Open Harpoon Marks",
		},
		{
			"<A-j>",
			mode = "n",
			function()
				require("harpoon.ui").nav_file(1)
			end,
			desc = "Harpoon 1 Mark",
		},
		{
			"<A-k>",
			mode = "n",
			function()
				require("harpoon.ui").nav_file(2)
			end,
			desc = "Harpoon 2 Mark",
		},
		{
			"<A-l>",
			mode = "n",
			function()
				require("harpoon.ui").nav_file(3)
			end,
			desc = "Harpoon 3 Mark",
		},
		{
			"<A-;>",
			mode = "n",
			function()
				require("harpoon.ui").nav_file(4)
			end,
			desc = "Harpoon 4 Mark",
		},
	},
	opts = function()
		require("telescope").load_extension("harpoon")
	end,
}
