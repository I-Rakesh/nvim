return {
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      -- { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      local lspconfig = require("lspconfig")

      local lsp_defaults = lspconfig.util.default_config

      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      })

      lsp_defaults.capabilities =
        vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("blink.cmp").get_lsp_capabilities(), {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        })
      require("mason-lspconfig").setup({
        ensure_installed = {},
        automatic_enable = {
          exclude = {
            "jdtls",
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
            "<leader>grd",
            "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>",
            { desc = "Go to Definition in split screen" }
          )
          vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, { desc = "Show Signature Documentation" })
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

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          local function client_supports_method(method, bufnr)
            if not client then
              return false
            end
            if vim.fn.has("nvim-0.11") == 1 then
              return client:supports_method(method, bufnr)
            else
              return client:supports_method(method, bufnr)
            end
          end

          if client and client_supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })

            -- initialize only if not set yet
            if vim.b.lsp_highlight_enabled == nil then
              vim.b.lsp_highlight_enabled = false -- default ON first time
            end

            -- apply autocommands only if enabled
            if vim.b.lsp_highlight_enabled then
              vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
              })

              vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
              })
            end

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
              end,
            })

            vim.keymap.set("n", "<leader>th", function()
              if vim.b.lsp_highlight_enabled then
                vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event.buf })
                vim.lsp.buf.clear_references()
                vim.b.lsp_highlight_enabled = false
                vim.notify("LSP Highlights: OFF", vim.log.levels.INFO)
              else
                vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                  buffer = event.buf,
                  group = highlight_augroup,
                  callback = vim.lsp.buf.document_highlight,
                })
                vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                  buffer = event.buf,
                  group = highlight_augroup,
                  callback = vim.lsp.buf.clear_references,
                })
                vim.b.lsp_highlight_enabled = true
                vim.notify("LSP Highlights: ON", vim.log.levels.INFO)
                vim.lsp.buf.document_highlight()
              end
            end, { buffer = event.buf, desc = "[T]oggle LSP Highlights" })
          end

          -- Inlay Hints toggle (unchanged, just adjusted to use same helper)
          if client and client_supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            vim.keymap.set("n", "<leader>ti", function()
              local bufnr = vim.api.nvim_get_current_buf()
              local new_state = not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
              vim.lsp.inlay_hint.enable(new_state, { bufnr = bufnr })
              vim.notify("Inlay hints: " .. (new_state and "ON" or "OFF"), vim.log.levels.INFO, { title = "LSP" })
            end, { desc = "[T]oggle Inlay [H]ints" })
          end
        end,
      })
      require("lspconfig.ui.windows").default_options.border = "rounded"
    end,
  },
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = {
      ui = {
        border = "rounded",
        backdrop = 100,
      },
    },
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
