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
vim.keymap.set({ "n" }, "<leader>tf", ":ToggleTerm direction=float<CR>")
vim.keymap.set({ "n" }, "<leader>tv", ":ToggleTerm direction=vertical<CR>")
vim.keymap.set({ "n" }, "<leader>th", ":ToggleTerm direction=horizontal<CR>")
vim.keymap.set({ "n" }, "<leader>tt", ":ToggleTerm direction=tab<CR>")

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", "<C-d>", opts)
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

vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true })
