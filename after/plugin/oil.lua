require("oil").setup({
	use_default_keymaps = false,

	keymaps = {
		["g?"] = "actions.show_help",
		["-"] = "actions.parent",
		["_"] = "actions.open_cwd",
		["`"] = "actions.cd",
		["~"] = "actions.tcd",
		["H"] = "actions.toggle_hidden",
		["<CR>"] = "actions.select",
	},
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
