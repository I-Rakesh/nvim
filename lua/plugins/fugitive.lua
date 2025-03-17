return {
  "tpope/vim-fugitive",
  dependencies = {
    "tpope/vim-rhubarb",
  },
  keys = {
    { "<leader>gs", mode = "n", vim.cmd.Git, desc = "Git Status" },
    { "<leader>gD", mode = "n", "<cmd>Git difftool<CR>", desc = "Git Difftool" },
    { "<leader>gp", mode = "n", "<cmd>Git push<CR>", desc = "Git Push" },
    { "<leader>gc", mode = "n", "<cmd>Git commit<CR>", desc = "Git Commit" },
    { "<leader>gl", mode = "n", "<cmd>Git log<CR>", desc = "Git Log" },
    { "<leader>gb", mode = "n", "<cmd>GBrowse<CR>", desc = "Open Github" },
  },
}
