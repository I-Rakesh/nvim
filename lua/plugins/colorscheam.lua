return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
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
      highlight_overrides = {
        all = function(colors)
          return {
            DiagnosticVirtualTextError = { bg = colors.none },
            DiagnosticVirtualTextWarn = { bg = colors.none },
            DiagnosticVirtualTextHint = { bg = colors.none },
            DiagnosticVirtualTextInfo = { bg = colors.none },
            MatchParen = { fg = "#ED6B21", bg = colors.none }, -- Replace 'teal' with your desired color
            -- Pmenu = { bg = colors.none }, -- for transparent completion menu
          }
        end,
      },
    })
    vim.cmd([[colorscheme  catppuccin ]])
  end,
}
