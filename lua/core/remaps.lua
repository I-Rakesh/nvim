vim.g.mapleader = " "

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

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- formate code based on Lsp
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- to change the word at the curser
vim.keymap.set("n", "<leader>cw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Makes a file executable
vim.keymap.set("n", "<leader>ex", "<cmd>!chmod +x %<CR>", { silent = true })

-- to close the current buffer
vim.keymap.set("n", "<leader>q", vim.cmd.bd)

-- to move between buffers
vim.keymap.set("n", "<S-f>", vim.cmd.bnext)
vim.keymap.set("n", "<S-b>", vim.cmd.bprevious)


-- to move between windows
vim.keymap.set({ "n" }, "<C-j>", "<C-w>j")
vim.keymap.set({ "n" }, "<C-k>", "<C-w>k")
vim.keymap.set({ "n" }, "<C-l>", "<C-w>l")
vim.keymap.set({ "n" }, "<C-h>", "<C-w>h")
