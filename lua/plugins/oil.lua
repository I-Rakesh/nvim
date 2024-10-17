return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  config = function()
    require("oil").setup({
      use_default_keymaps = false,
      delete_to_trash = true,
      preview = {
        win_options = {
          winhl = "Normal:Normal,Float:Float",
        },
      },
      keymaps = {
        ["H"] = "actions.toggle_hidden",
        ["<A-t>"] = "actions.select_tab",
        ["<A-v>"] = "actions.select_vsplit",
        ["<A-r>"] = "actions.refresh",
        ["<A-x>"] = "actions.select_split",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["<C-c>"] = "actions.close",
        ["<C-p>"] = "actions.preview",
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["g\\"] = "actions.toggle_trash",
      },
    })
    vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end,
}
