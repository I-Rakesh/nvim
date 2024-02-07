return {
  "stevearc/oil.nvim",
  config = function()
    require("oil").setup({
      -- use_default_keymaps = false,

      keymaps = {
        ["H"] = "actions.toggle_hidden",
        ["<A-r>"] = "actions.refresh",
      },
    })
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end,
}
