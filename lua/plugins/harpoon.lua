return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  -- stylua: ignore
  keys = {
    { "<leader>m",  mode = "n", function() require("harpoon"):list():add() end,                                    desc = "Harpoon Mark", },
    { "<leader>sh", mode = "n", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Open Harpoon Marks", },
    { "<A-j>",      mode = "n", function() require("harpoon"):list():select(1) end,                                desc = "Harpoon 1 Mark", },
    { "<A-k>",      mode = "n", function() require("harpoon"):list():select(2) end,                                desc = "Harpoon 2 Mark", },
    { "<A-l>",      mode = "n", function() require("harpoon"):list():select(3) end,                                desc = "Harpoon 3 Mark", },
    { "<A-;>",      mode = "n", function() require("harpoon"):list():select(4) end,                                desc = "Harpoon 4 Mark", },
  },
  config = function()
    require("harpoon").setup({
      settings = {
        save_on_toggle = true,
      },
    })
  end,
}
