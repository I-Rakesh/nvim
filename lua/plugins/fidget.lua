return {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  opts = {
    notification = {
      window = {
        winblend = 0,
      },
    },
  },
  config = function(_, opts)
    -- Setup fidget with your options
    require("fidget").setup(opts)

    -- Override vim.notify to use fidget
    vim.notify = require("fidget").notify
  end,
}
