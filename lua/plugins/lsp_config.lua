return {
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      -- { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      -- The below are handled by noice
      -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

      -- vim.lsp.handlers["textDocument/signatureHelp"] =
      --     vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

      local lspconfig = require("lspconfig")

      local lsp_defaults = lspconfig.util.default_config

      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      lsp_defaults.capabilities =
        vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())
      require("mason-lspconfig").setup({
        ensure_installed = {},
        automatic_enable = {
          exclude = {
            "jdtls",
          },
        },
      })
      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--offset-encoding=utf-16",
        },
      })

      vim.lsp.config("bashls", {
        settings = {
          bashIde = {
            -- Disable shellcheck in bash-language-server. It conflicts with linter settings. And it is slow compared conform.nvim
            shellcheckPath = "",
          },
        },
      })

      vim.lsp.config("ts_ls", {
        settings = {
          javascript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = false,
            },
          },

          typescript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = false,
            },
          },
        },
      })

      local diagnostic_jump = function(next, severity)
        local count = next and 1 or -1
        severity = severity and vim.diagnostic.severity[severity] or nil
        return function()
          vim.diagnostic.jump({ count = count, float = true, severity = severity })
        end
      end
      vim.keymap.set("n", "]d", diagnostic_jump(true), { desc = "Next Diagnostic" })
      vim.keymap.set("n", "[d", diagnostic_jump(false), { desc = "Prev Diagnostic" })
      vim.keymap.set("n", "]e", diagnostic_jump(true, "ERROR"), { desc = "Next Error" })
      vim.keymap.set("n", "[e", diagnostic_jump(false, "ERROR"), { desc = "Prev Error" })
      vim.keymap.set("n", "]w", diagnostic_jump(true, "WARN"), { desc = "Next Warning" })
      vim.keymap.set("n", "[w", diagnostic_jump(false, "WARN"), { desc = "Prev Warning" })
      vim.keymap.set("n", "[t", diagnostic_jump(false, "HINT"), { desc = "Prev Hint" })
      vim.keymap.set("n", "]t", diagnostic_jump(true, "HINT"), { desc = "Next Hint" })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(event)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          vim.keymap.set("n", "grD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
          vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "Go to Definition" })
          vim.keymap.set(
            "n",
            "<leader>gd",
            "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>",
            { desc = "Go to Definition in split screen" }
          )
          vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, { desc = "Show Signature Documentation" })
          -- vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
          -- vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to Reference's" })
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "lsp Add Workspace Folder" })
          vim.keymap.set(
            "n",
            "<leader>wr",
            vim.lsp.buf.remove_workspace_folder,
            { desc = "lsp Rmove Workspace Folder" }
          )
          vim.keymap.set("n", "<leader>wl", function()
            vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, { desc = "lsp List Workspace Folders" })
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition)
          -- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "lsp Rename" })
          -- vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "lsp Code Actions" })
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, { desc = "Format the current file" })

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.keymap.set("n", "<leader>gi", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
            end, { desc = "[T]oggle Inlay [H]ints" })
          end
        end,
      })
      require("lspconfig.ui.windows").default_options.border = "rounded"
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = {
      "MasonToolsUpdate",
      "MasonToolsInstall",
      "MasonToolsClean",
      "MasonToolsInstallSync",
      "MasonToolsUpdateSync",
    },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          --Lsp servers
          "lua_ls",
          "clangd",
          "pyright",
          "jdtls",
          "bashls",
          "marksman",
          "ts_ls",
          --Formatters
          "stylua",
          "clang-format",
          "ruff",
          "black",
          "prettier",
          "isort",
          -- Linters
          "shfmt",
          "shellcheck",
          "mypy",
          "eslint",
          --Debugger
          "java-debug-adapter",
          "java-test",
          "codelldb",
          "debugpy",
          "js-debug-adapter",
        },
      })
    end,
  },
}
