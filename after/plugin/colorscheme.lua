vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme  gruvbox ]])

require("catppuccin").setup({
  transparent_background = true,
})
require('rose-pine').setup({
  disable_background = true,
  disable_float_background = true,
})

function ColorMyPencils(color)
  color = color or "gruvbox"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
