return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  opts = { use_diagnostic_signs = true },
  -- stylua: ignore
  keys = {
    { "<leader>t;", "<cmd>TroubleToggle<cr>",                       desc = " Toggle Trouble" },
    { "<leader>tdb", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics (Trouble)" },
    { "<leader>tdw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    { "<leader>tl", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List (Trouble)" },
    { "<leader>tq", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List (Trouble)" },
    { "<leader>tr", "<cmd>TroubleToggle lsp_references<cr>",        desc = "Lsp reference (Trouble)" },
    { "<leader>te", "<cmd>TroubleToggle telescope<cr>",             desc = "Trouble Telescope(Trouble)" },
    {
      "[q",
      function()
        if require("trouble").is_open() then
          require("trouble").previous({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Previous trouble/quickfix item",
    },
    {
      "]q",
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Next trouble/quickfix item",
    },
  },
  dependencies = { "kyazdani42/nvim-web-devicons" },
}
