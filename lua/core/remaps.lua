vim.g.mapleader = " "

--tmux-sessions
vim.keymap.set(
  "n",
  "<C-f>",
  "<cmd>silent !tmux neww ~/.local/scripts/tmux-sessionizer<CR>",
  { desc = "tmux-sessionizer" }
)

--Remap to clear Highlight when searching
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch" })

--Macro
vim.keymap.set("n", "Q", "@@", { desc = "Replay a Macro" })
vim.keymap.set("v", "Q", ":norm @@<CR>", { silent = true, desc = "Replay a Macro" })

-- Color column
vim.api.nvim_set_keymap(
  "n",
  "<Leader>cc",
  ':let &colorcolumn = empty(&colorcolumn) ? "80" : ""<CR><cmd>echo "Color Column Toggled"<CR>',
  { noremap = true, silent = true, desc = "Toggle Color Column" }
)

-- Redo
vim.keymap.set("n", "<S-u>", "<C-r>", { desc = "Redo" })

-- to move selected text up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move Selected Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move Selected Up" })

-- to keep the cursor in the middle while moving and searching
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- to Preserve copied text to past without loosing
vim.keymap.set("n", "<leader>p", [["+p]], { desc = "Past To System Clipbord" })

-- to copy into system clipboard or vim buffer
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy Selected To System Clipbord" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy Line To System Clipbord" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Deleat Without Coping" })
vim.keymap.set({ "n", "v" }, "X", [["_x]], { desc = "Deleat Letter Without Coping" })

-- format code based on Lsp
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Formater" })

-- to change the word at the cursor
vim.keymap.set("n", "<leader>cw", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = "Change Word" })
vim.keymap.set("v", "<leader>cw", '"hy:%s/<C-r>h//g<left><left>', { desc = "Change Word" })

-- Makes a file executable
vim.keymap.set("n", "<leader>ex", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make File Executable" })

-- to close the current buffer
vim.keymap.set("n", "<leader>x", vim.cmd.bd, { desc = "Close Current Buffer" })
vim.keymap.set("n", "<leader>X", "<cmd>%bd|edit#|bd#<CR>", { desc = "Close All Buffers Exept Current" })
vim.keymap.set("n", "<leader>dx", "<cmd>%bd<CR>", { desc = "Close All Buffers" })

-- to close tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabc<CR>", { desc = "Close Current Tab" })

-- to move between buffers
vim.keymap.set("n", "<Tab>", vim.cmd.bnext, { desc = "Next Buffer" })
vim.keymap.set("n", "<S-Tab>", vim.cmd.bprevious, { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>'", "<C-^>", { desc = "Previous Opened Buffer" })

-- to move between windows
vim.keymap.set({ "n", "i" }, "<C-j>", "<Esc><C-w>j", { desc = "Move Curser Down" })
vim.keymap.set({ "n", "i" }, "<C-k>", "<Esc><C-w>k", { desc = "Move Curser Up" })
vim.keymap.set({ "n", "i" }, "<C-l>", "<Esc><C-w>l", { desc = "Move Curser  Right" })
vim.keymap.set({ "n", "i" }, "<C-h>", "<Esc><C-w>h", { desc = "Move Curser Left" })

-- to rearrange window
vim.keymap.set({ "n" }, "<leader>H", "<Esc><C-w>H", { desc = "Move Window Left" })
vim.keymap.set({ "n" }, "<leader>J", "<Esc><C-w>J", { desc = "Move Window Down" })
vim.keymap.set({ "n" }, "<leader>K", "<Esc><C-w>K", { desc = "Move Window  Up" })
vim.keymap.set({ "n" }, "<leader>L", "<Esc><C-w>L", { desc = "Move Window Right" })
vim.keymap.set(
  "n",
  "<leader><C-" .. vim.g.mapleader .. ">",
  "<Esc><C-w><C-r>",
  { noremap = true, desc = "Swap Window Positions" }
)

-- to resize panes
vim.keymap.set("n", "<A-p>", [[<cmd>vertical resize +5<cr>]], { desc = "Resize Window Vertical+" })
vim.keymap.set("n", "<A-m>", [[<cmd>vertical resize -5<cr>]], { desc = "Resize Window Vertical-" })
vim.keymap.set("n", "<A-=>", [[<cmd>horizontal resize +2<cr>]], { desc = "Resize Window Horizantal+" })
vim.keymap.set("n", "<A-->", [[<cmd>horizontal resize -2<cr>]], { desc = "Resize Window Horizantal-" })
vim.keymap.set("n", "<leader>-", "<C-w>_", { desc = "Maxinize Horzantal Split" })
vim.keymap.set("n", "<leader>=", "<C-w>=", { desc = "Equlize Splipts" })

-- to open new panes
vim.keymap.set("n", '<leader>"', "<cmd>new<CR>", { desc = "New Horzantal Split" })
vim.keymap.set("n", "<leader>%", "<cmd>vnew<CR>", { desc = "New Vertical Split" })

--to go to normal mood in terminal mood
vim.keymap.set("t", "'<ESC>", "<C-\\><C-n>", { noremap = true })
