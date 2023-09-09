local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
require("telescope").load_extension('harpoon')

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-i>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-o>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-p>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-[>", function() ui.nav_file(4) end)
