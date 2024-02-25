return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  opts = {
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { zindex = 100 })
    end,
  },
  config = function()
    vim.notify = require("notify")
    require("notify").setup({
      timeout = 1000,
      stages = "fade_in_slide_out",
      background_colour = "#000000",
    })
  end,
}
