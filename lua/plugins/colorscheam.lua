return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = false, -- disables setting the background color.
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
      custom_highlights = function()
        return {
          MatchParen = { fg = "#ED6B21" }, -- Replace 'teal' with your desired color
        }
      end,
      highlight_overrides = {
        all = function(colors)
          return {
            DiagnosticVirtualTextError = { bg = colors.none },
            DiagnosticVirtualTextWarn = { bg = colors.none },
            DiagnosticVirtualTextHint = { bg = colors.none },
            DiagnosticVirtualTextInfo = { bg = colors.none },
          }
        end,
      },
    })
    vim.cmd([[colorscheme  catppuccin ]])
  end,
}
