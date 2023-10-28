return {
	"ThePrimeagen/harpoon",
	event = "VeryLazy",
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")
		require("telescope").load_extension("harpoon")

		vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon Mark" })
		vim.keymap.set("n", "<leader>sh", ui.toggle_quick_menu, { desc = "Open Harpoon Marks" })

		vim.keymap.set("n", "ø", function()
			ui.nav_file(1)
		end, { desc = "Harpoon 1 Mark" })
		vim.keymap.set("n", "…", function()
			ui.nav_file(2)
		end, { desc = "Harpoon 2 Mark" })
		vim.keymap.set("n", "≤", function()
			ui.nav_file(3)
		end, { desc = "Harpoon 3 Mark" })
		vim.keymap.set("n", "≥", function()
			ui.nav_file(4)
		end, { desc = "Harpoon 4 Mark" })
	end,
}
