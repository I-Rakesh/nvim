return {
  "stevearc/oil.nvim",
  config = function()
    require("oil").setup({
      use_default_keymaps = false,

      keymaps = {
        ["g?"] = "actions.show_help",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["H"] = "actions.toggle_hidden",
        ["<CR>"] = "actions.select",
        ["<C-x>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-s>"] = "actions.change_sort",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
      },
    })
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end,
}
