return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "frappe",            -- latte, frappe, macchiato, mocha
      transparent_background = true, -- disables setting the background color.
      integrations = {
        telescope = {
          enabled = true,
          style = "nvchad",
        },
        noice = true,
      },
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        conditionals = {},
      },
    })
    vim.cmd([[colorscheme  catppuccin ]])
  end,
}
