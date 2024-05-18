return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "f3fora/cmp-spell",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind.nvim",
    "rafamadriz/friendly-snippets",
    { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
  },
  config = function()
    require("lspkind").init({
      symbol_map = {
        Copilot = "",
      },
    })
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    require("luasnip.loaders.from_vscode").lazy_load()
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    cmp.setup({
      -- completion = { completeopt = "menu,menuone,noinsert" },
      -- view = {
      --   entries = {
      --     follow_cursor = true,
      --   },
      -- },
      mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-j>"] = cmp.mapping.complete({}),
        ["<C-l>"] = cmp.mapping(function()
          if require("luasnip").expand_or_locally_jumpable() then
            require("luasnip").expand_or_jump()
          end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
          if require("luasnip").locally_jumpable(-1) then
            require("luasnip").jump(-1)
          end
        end, { "i", "s" }),
      }),

      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        {
          name = "spell",
          option = {
            keep_all_entries = false,
            enable_in_context = function()
              return require("cmp.config.context").in_treesitter_capture("spell")
            end,
          },
        },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
      experimental = {
        ghost_text = false,
      },
      -- for border around completion menu
      window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
      },
      cmp.setup.filetype({ "sql" }, {
        sources = {
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
        },
      }),
    })
  end,
}
