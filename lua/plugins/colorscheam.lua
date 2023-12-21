return {
  {
    "navarasu/onedark.nvim",
    config = function()
      vim.o.background = "dark" -- or "light" for light mode
      vim.cmd([[colorscheme  catppuccin ]])

      require("onedark").setup({
        transparent = true,
        lualine = {
          transparent = true,
        },
      })

      -- Function to make any theme transprant
      -- function ColorMyPencils(color)
      --   color = color or "catppuccin"
      --   vim.cmd.colorscheme(color)
      --
      --   vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      --   vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      -- end
      --
      -- ColorMyPencils()
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe",        -- latte, frappe, macchiato, mocha
        transparent_background = true, -- disables setting the background color.
      })
    end,
  },
}
