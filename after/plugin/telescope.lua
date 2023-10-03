local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
vim.keymap.set("n", "<leader>sf", builtin.find_files, {})
vim.keymap.set("n", "<leader>sw", builtin.live_grep, {})
vim.keymap.set("n", "<leader>sb", builtin.buffers, {})
vim.keymap.set("n", "<leader>st", builtin.help_tags, {})
vim.keymap.set("n", "<leader>sg", builtin.git_files, {})
vim.keymap.set("n", "<leader>ch", builtin.colorscheme, {})
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, {})
vim.keymap.set("n", "<leader>sr", builtin.lsp_references, {})
vim.keymap.set("n", "<leader>ss", builtin.lsp_document_symbols, {})
vim.keymap.set("n", "<leader>sj", builtin.jumplist, {})
vim.keymap.set("n", "<leader>sm", builtin.marks, {})
vim.keymap.set("n", "<leader>so", builtin.oldfiles, {})
vim.keymap.set("n", "<leader>s*", builtin.grep_string, {})
vim.keymap.set("n", "<leader>sch", builtin.command_history, {})
vim.keymap.set("n", "<leader>z", builtin.spell_suggest, {})
vim.keymap.set("n", "<leader>s/", function()
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end, { desc = "Search Current Buffer" })

require("telescope").setup({
	defaults = {
		mappings = {
			i = { ["<leader>q"] = actions.send_to_qflist + actions.open_qflist },
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = "   ",
		selection_caret = "  ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules", ".class" },
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "truncate" },
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		use_less = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
	},
})
