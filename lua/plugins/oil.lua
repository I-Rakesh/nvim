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
        ["gv"] = "actions.select_vsplit",
        ["gx"] = "actions.select_split",
        ["gs"] = "actions.change_sort",
        ["gt"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
      },
    })
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end,
}
