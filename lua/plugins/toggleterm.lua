return {
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
	config = function()
		require("toggleterm").setup({
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			shade_filetypes = {},
			shade_terminal = true,
			shading_factor = 1,
			start_in_insert = true,
			persist_size = true,
			direction = "float",
			autochdir = true,
		})
		vim.keymap.set(
			{ "n" },
			"<leader>tf",
			"<cmd>ToggleTerm direction=float<CR>",
			{ desc = "Open Terminal In Float" }
		)
		vim.keymap.set(
			{ "n" },
			"<leader>tv",
			"<cmd>ToggleTerm direction=vertical<CR>",
			{ desc = "Open Terminal In Vertical Split" }
		)
		vim.keymap.set(
			{ "n" },
			"<leader>th",
			"<cmd>ToggleTerm direction=horizontal<CR>",
			{ desc = "Open Terminal In Horizontal Split" }
		)
		vim.keymap.set({ "n" }, "<leader>tt", "<cmd>ToggleTerm direction=tab<CR>", { desc = "Open Terminal In Tab" })

		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
		end

		-- if you only want these mappings for toggle term use term://*toggleterm#* instead
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

		function _LAZYGIT_TOGGLE()
			lazygit:toggle()
		end

		vim.api.nvim_set_keymap(
			"n",
			"<leader>lg",
			"<cmd>lua _LAZYGIT_TOGGLE()<CR>",
			{ noremap = true, silent = true, desc = "Toggle LazyGit" }
		)
	end,
}
