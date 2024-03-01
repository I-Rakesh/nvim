return {
  "sindrets/diffview.nvim",
  keys = {
    { "<leader>dv", mode = { "n" }, "<cmd>DiffviewOpen<CR>", desc = "DiffView" },
    { "<leader>dcv", mode = { "n" }, ":DiffviewOpen ", desc = "DiffView Specific File Commit" },
    { "<leader>dh", mode = { "n" }, "<cmd>DiffviewFileHistory %<CR>", desc = "DiffView Current File Histoyr" },
    { "<leader>dbh", mode = { "n" }, "<cmd>DiffviewFileHistory<CR>", desc = "DiffView Current Branch Histoyr" },
    { "<leader>dn", mode = { "n" }, "<cmd>DiffviewToggleFiles<CR>", desc = "DiffView File Tree" },
  },
  config = function() end,
}
