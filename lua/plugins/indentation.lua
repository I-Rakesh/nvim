return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    dependencies = "echasnovski/mini.indentscope",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "oil_preview",
          "lspinfo",
          "DiffviewFiles",
        },
      },
    },
    main = "ibl",
  },
  {
    "echasnovski/mini.indentscope",
    lazy = true,
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "oil_preview",
          "lspinfo",
          "DiffviewFiles",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
