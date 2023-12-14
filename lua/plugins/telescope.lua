return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	tag = "0.1.3",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search files" })
		vim.keymap.set("n", "<leader>sw", builtin.live_grep, { desc = "Search Word" })
		vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Search Buffer" })
		vim.keymap.set("n", "<leader>st", builtin.help_tags, { desc = "Search Help Tags" })
		vim.keymap.set("n", "<leader>sk", ":Telescope keymaps<CR>", { desc = "Search Keymaps" })
		vim.keymap.set("n", "<leader>sg", builtin.git_files, { desc = "Search Git" })
		vim.keymap.set("n", "<leader>ch", builtin.colorscheme, { desc = "Change Color Scheme" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search Diagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.lsp_references, { desc = "Search References" })
		vim.keymap.set("n", "<leader>ss", builtin.lsp_document_symbols, { desc = "Search Symbles" })
		vim.keymap.set("n", "<leader>sj", builtin.jumplist, { desc = "Search Jumplist" })
		vim.keymap.set("n", "<leader>sm", builtin.marks, { desc = "Search Marks" })
		vim.keymap.set("n", "<leader>so", builtin.oldfiles, { desc = "Search Old Files" })
		vim.keymap.set("n", "<leader>s*", builtin.grep_string, { desc = "Search Current Word" })
		vim.keymap.set("n", "<leader>s:", builtin.command_history, { desc = "Search Command History" })
		vim.keymap.set("n", "<leader>z", builtin.spell_suggest, { desc = "Search Spell Suggestion's" })
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
	end,
}
