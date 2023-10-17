return {
  "nvim-tree/nvim-tree.lua",
  event = "VeryLazy",
  config = function()
    require("nvim-tree").setup({
      view = {
        adaptive_size = true,
      },
      filters = {
        dotfiles = true,
      },
    })

    vim.keymap.set("n", "<c-n>", ":NvimTreeFindFileToggle<CR>")
  end,
}
