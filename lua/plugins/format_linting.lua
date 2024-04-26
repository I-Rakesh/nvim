return {
  {
    "stevearc/conform.nvim",
    event = "BufWrite",
    keys = {
      {
        "<leader>f",
        mode = { "n", "v" },
        function()
          require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
        end,
        desc = "Format file or range (in visual mode)",
      },
    },
    config = function()
      require("conform").setup({

        formatters_by_ft = {
          lua = { "stylua" },
          c = { "clang_format" },
          cpp = { "clang_format" },
          java = { "clang_format" },
          python = { "isort", "black" },
          sh = { "shfmt" },
          markdown = { "prettier" },
          javascript = { "prettier" },
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 1000,
          lsp_fallback = true,
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = "User FilePost",
    config = function()
      require("lint").linters_by_ft = {
        python = { "mypy", "ruff" },
        sh = { "Shellcheck" },
        javascript = { "eslint" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          require("lint").try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>l", function()
        require("lint").try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
}
