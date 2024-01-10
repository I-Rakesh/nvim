return {
  "mbbill/undotree",
  keys = {
    { "<leader>u", mode = "n", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
  },
  config = function()
    vim.g.undotree_WindowLayout = 2
  end,
}
