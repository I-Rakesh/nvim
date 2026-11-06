return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
  },
  config = function()
    require("nvim-treesitter").setup({
      ignore_install = {},
      modules = {},
      ensure_installed = { "c", "lua", "vim", "query", "python", "cpp", "java", "bash", "markdown" },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      indent = { enable = true },
      autopairs = {
        enable = true,
      },
    })

    --Treesitter-text_objects
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,

        selection_modes = {
          ["@parameter.outer"] = "v",
          ["@function.outer"] = "V",
          -- ["@class.outer"] = "<c-v>",
        },

        include_surrounding_whitespace = false,
      },
    })

    local select = require("nvim-treesitter-textobjects.select")

    vim.keymap.set({ "x", "o" }, "aa", function()
      select.select_textobject("@parameter.outer", "textobjects")
    end)

    vim.keymap.set({ "x", "o" }, "ia", function()
      select.select_textobject("@parameter.inner", "textobjects")
    end)

    vim.keymap.set({ "x", "o" }, "af", function()
      select.select_textobject("@function.outer", "textobjects")
    end)

    vim.keymap.set({ "x", "o" }, "if", function()
      select.select_textobject("@function.inner", "textobjects")
    end)

    vim.keymap.set({ "x", "o" }, "ac", function()
      select.select_textobject("@class.outer", "textobjects")
    end)

    vim.keymap.set({ "x", "o" }, "ic", function()
      select.select_textobject("@class.inner", "textobjects")
    end)

    vim.keymap.set({ "x", "o" }, "al", function()
      select.select_textobject("@loop.outer", "textobjects")
    end)

    vim.keymap.set({ "x", "o" }, "il", function()
      select.select_textobject("@loop.inner", "textobjects")
    end)

    vim.keymap.set({ "x", "o" }, "ai", function()
      select.select_textobject("@conditional.outer", "textobjects")
    end)

    vim.keymap.set({ "x", "o" }, "ii", function()
      select.select_textobject("@conditional.inner", "textobjects")
    end)

    vim.keymap.set({ "x", "o" }, "am", function()
      select.select_textobject("@comment.outer", "textobjects")
    end)

    vim.keymap.set({ "x", "o" }, "im", function()
      select.select_textobject("@comment.inner", "textobjects")
    end)

    -----------------------------------------------------------------------
    -- Move keymaps
    -----------------------------------------------------------------------
    local move = require("nvim-treesitter-textobjects.move")

    vim.keymap.set({ "n", "x", "o" }, "]f", function()
      move.goto_next_start("@function.outer", "textobjects")
    end)

    vim.keymap.set({ "n", "x", "o" }, "]F", function()
      move.goto_next_end("@function.outer", "textobjects")
    end)

    vim.keymap.set({ "n", "x", "o" }, "[f", function()
      move.goto_previous_start("@function.outer", "textobjects")
    end)

    vim.keymap.set({ "n", "x", "o" }, "[F", function()
      move.goto_previous_end("@function.outer", "textobjects")
    end)

    vim.keymap.set({ "n", "x", "o" }, "]c", function()
      move.goto_next_start("@class.outer", "textobjects")
    end)

    vim.keymap.set({ "n", "x", "o" }, "]C", function()
      move.goto_next_end("@class.outer", "textobjects")
    end)

    vim.keymap.set({ "n", "x", "o" }, "[c", function()
      move.goto_previous_start("@class.outer", "textobjects")
    end)

    vim.keymap.set({ "n", "x", "o" }, "[C", function()
      move.goto_previous_end("@class.outer", "textobjects")
    end)

    -----------------------------------------------------------------------
    -- Swap keymaps
    -----------------------------------------------------------------------
    local swap = require("nvim-treesitter-textobjects.swap")

    vim.keymap.set("n", "<leader>a", function()
      swap.swap_next("@parameter.inner")
    end)

    vim.keymap.set("n", "<leader>A", function()
      swap.swap_previous("@parameter.inner")
    end)
  end,
}
