vim.g.mapleader = " "

-- Redo
vim.keymap.set("n","<C-r>","<S-u>")

-- to move selected text up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- to keep the curser in the middle while moving and searching
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- to presearve copied text to past without loosing
vim.keymap.set("x", "<leader>p", [["_dP]])

-- to copy into system clipbord or vim buffer
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- formate code based on Lsp
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- to change the word at the curser
vim.keymap.set("n", "<leader>cw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Makes a file executable
vim.keymap.set("n", "<leader>ex", "<cmd>!chmod +x %<CR>", { silent = true })

-- to close the current buffer
vim.keymap.set("n", "<leader>x", vim.cmd.bd)
vim.keymap.set("n", "<leader>X", ":%bd|edit#|bd#<CR>")

-- to move between buffers
vim.keymap.set("n", "[b", vim.cmd.bnext)
vim.keymap.set("n", "]b", vim.cmd.bprevious)


-- to move between windows
vim.keymap.set({ "n","i" }, "<C-j>", "<Esc><C-w>j")
vim.keymap.set({ "n","i" }, "<C-k>", "<Esc><C-w>k")
vim.keymap.set({ "n","i" }, "<C-l>", "<Esc><C-w>l")
vim.keymap.set({ "n","i" }, "<C-h>", "<Esc><C-w>h")

-- to rearrnge window
vim.keymap.set({ "n" }, "<leader>H", "<Esc><C-w>H")
vim.keymap.set({ "n" }, "<leader>J", "<Esc><C-w>J")
vim.keymap.set({ "n" }, "<leader>K", "<Esc><C-w>K")
vim.keymap.set({ "n" }, "<leader>L", "<Esc><C-w>L")
vim.keymap.set({ "n" }, "<C-" .. vim.g.mapleader .. ">", "<Esc><C-w><C-r>", { noremap = true })

-- Change window layout
vim.keymap.set("n", "<leader>V", "<Esc><C-w>H")
vim.keymap.set("n", "<leader>S", "<Esc><C-w>K")

-- to resize panes
vim.keymap.set("n", "+", [[<cmd>vertical resize +5<cr>]]) -- make the window biger vertically
vim.keymap.set("n", "_", [[<cmd>vertical resize -5<cr>]]) -- make the window smaller vertically
vim.keymap.set("n", "≠", [[<cmd>horizontal resize +2<cr>]]) -- make the window bigger horizontally by pressing shift and =
vim.keymap.set("n", "–", [[<cmd>horizontal resize -2<cr>]]) -- make the window smaller horizontally by pressing shift and -
vim.keymap.set("n", "<leader>-", "<C-w>_")
vim.keymap.set("n", "<leader>=", "<C-w>=")

-- to open new panes
vim.keymap.set("n", '<leader>"', ":new<CR><C-w><C-r>")
vim.keymap.set("n", '<leader>%', ":vnew<CR><C-w><C-r>")

-- Navigate between quickfix items
vim.keymap.set("n", "[q", "<cmd>cnext<CR>zz", { desc = "Forward qfixlist"})
vim.keymap.set("n", "]q", "<cmd>cprev<CR>zz", { desc = "Backward qfixlist"})
vim.keymap.set("n", "<leader>q", "<cmd>copen<CR>")
