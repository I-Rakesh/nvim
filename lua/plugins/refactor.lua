return {
  "ThePrimeagen/refactoring.nvim",
  -- stylua: ignore
  keys = {
    { "<leader>re", mode = { "n", "x" }, function() require("telescope").extensions.refactoring.refactors() end, desc = "Refactor Code" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("refactoring").setup()
    require("telescope").load_extension("refactoring")
  end,
}
