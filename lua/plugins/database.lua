return {
  {
    "tpope/vim-dadbod",
    config = function() end,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    keys = {
      { "<leader>du", mode = "n", "<cmd>DBUIToggle<CR>", desc = "Detabase UI Toggle" },
    },
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}
