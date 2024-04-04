return {
  "stevearc/dressing.nvim",
  lazy = true,
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
      require("lazy").load({ plugins = { "dressing.nvim" } })
      return vim.ui.select(...)
    end
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.input = function(...)
      require("lazy").load({ plugins = { "dressing.nvim" } })
      return vim.ui.input(...)
    end
  end,
  config = function()
    require("dressing").setup({
      input = {
        buf_options = {},
        insert_only = false,
        win_options = {
          winhighlight = "Normal:MyNormal",
          winblend = 0,
        },
      },
    })
  end,
}
