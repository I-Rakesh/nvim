return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			current_line_blame = false,
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]h", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				map("n", "[h", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				-- Actions
				map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Git Stage Hunk" })
				map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Git Restore Hunk" })
				map("n", "<leader>hS", gs.stage_buffer, { desc = "Git Stage Buffer" })
				map("n", "<leader>hs", gs.stage_hunk, { desc = "Git Stage Hunk" })
				map("n", "<leader>hus", gs.undo_stage_hunk, { desc = "Git Undo Staged Hunk" })
				map("n", "<leader>hR", gs.reset_buffer, { desc = "Git Restore Buffer" })
				map("n", "<leader>hi", gs.preview_hunk, { desc = "Git Preview Hunk" })
				map("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end, { desc = "Git Blame_line" })
				map("n", "<leader>htb", gs.toggle_current_line_blame, { desc = "Git Toggle Current Line Blame" })
				map("n", "<leader>gd", gs.diffthis, { desc = "Git Difftool" })
				map("n", "<leader>hD", function()
					gs.diffthis("~")
				end, { desc = "Git Difftool ~" })
				map("n", "<leader>htd", gs.toggle_deleted, { desc = "Git Toggle Delete" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
			{ desc = "Git Select Hunk" },
		})
	end,
}
