return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})
		require("mason-tool-installer").setup({
			ensure_installed = {
				--Lsp servers
				"lua_ls",
				"clangd",
				"pyright",
				"jdtls",
				"bashls",
				"marksman",
				--Formatters
				"stylua",
				"clang-format",
				"ruff",
				"black",
				"prettier",
				-- Linters
				"shfmt",
				"shellcheck",
				"mypy",
			},
		})

		local lspconfig = require("lspconfig")

		local lsp_defaults = lspconfig.util.default_config

		lsp_defaults.capabilities =
			vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

		require("lspconfig").lua_ls.setup({
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

		require("lspconfig").clangd.setup({
			cmd = {
				"clangd",
				"--offset-encoding=utf-16",
			},
		})
		require("lspconfig").pyright.setup({})
		require("lspconfig").bashls.setup({})
		require("lspconfig").marksman.setup({})

		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "lsp Goto previous diagnostic" })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "lsp Goto next diagnostic" })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show Documentation" })
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
				vim.keymap.set(
					"n",
					"<space>wa",
					vim.lsp.buf.add_workspace_folder,
					{ desc = "lsp Add Workspace Folder" }
				)
				vim.keymap.set(
					"n",
					"<space>wr",
					vim.lsp.buf.remove_workspace_folder,
					{ desc = "lsp Rmove Workspace Folder" }
				)
				vim.keymap.set("n", "<space>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, { desc = "lsp List Workspace Folders" })
				vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition)
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { desc = "lsp Rename" })
				vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { desc = "lsp Code Actions" })
				vim.keymap.set("n", "<space>f", function()
					vim.lsp.buf.format({ async = true })
				end, { desc = "lsp Format" })
			end,
		})
	end,
}
