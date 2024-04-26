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
        handlers = {
          function(server_name)
            if server_name == "jdtls" then
              return
            end
            require("lspconfig")[server_name].setup({})
          end,
        },
      })

      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      })

      lspconfig.clangd.setup({
        cmd = {
          "clangd",
          "--offset-encoding=utf-16",
        },
      })

      lspconfig.bashls.setup({
        settings = {
          bashIde = {
            -- Disable shellcheck in bash-language-server. It conflicts with linter settings. And it is slow compared conform.nvim
            shellcheckPath = "",
          },
        },
      })

      local diagnostic_goto = function(next, severity)
        local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
        severity = severity and vim.diagnostic.severity[severity] or nil
        return function()
          go({ severity = severity })
        end
      end
      vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
      vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
      vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
      vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
      vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
      vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
      vim.keymap.set("n", "[t", diagnostic_goto(false, "HINT"), { desc = "Prev Hint" })
      vim.keymap.set("n", "]t", diagnostic_goto(true, "HINT"), { desc = "Next Hint" })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
          vim.keymap.set(
            "n",
            "<leader>gd",
            "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>",
            { desc = "Go to Definition in split screen" }
          )
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show Hover Documentation" })
          vim.keymap.set("n", "gk", vim.lsp.buf.signature_help, { desc = "Show Signature Documentation" })
          vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to Reference's" })
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
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "lsp Rename" })
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "lsp Code Actions" })
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).

          -- Activate if needed

          --[[ local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = ev.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = ev.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end ]]
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
          "tsserver",
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
