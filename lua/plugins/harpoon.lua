return {
  "ThePrimeagen/harpoon",
  -- stylua: ignore
  keys = {
    { "<leader>m",  mode = "n", function() require("harpoon.mark").add_file() end,            desc = "Harpoon Mark", },
    { "<leader>sh", mode = "n", function() require("harpoon.ui").toggle_quick_menu() end,     desc = "Open Harpoon Marks", },
    { "<A-j>",      mode = "n", function() require("harpoon.ui").nav_file(1) end,             desc = "Harpoon 1 Mark", },
    { "<A-k>",      mode = "n", function() require("harpoon.ui").nav_file(2) end,             desc = "Harpoon 2 Mark", },
    { "<A-l>",      mode = "n", function() require("harpoon.ui").nav_file(3) end,             desc = "Harpoon 3 Mark", },
    { "<A-;>",      mode = "n", function() require("harpoon.ui").nav_file(4) end,             desc = "Harpoon 4 Mark", },
    { "<leader>tj", mode = "n", function() require("harpoon.tmux").gotoTerminal(1) end,       desc = "Harpoon Terminal (Tmux) 1", },
    { "<leader>tk", mode = "n", function() require("harpoon.tmux").gotoTerminal(2) end,       desc = "Harpoon Terminal (Tmux) 2", },
    { "<leader>tl", mode = "n", function() require("harpoon.tmux").gotoTerminal(3) end,       desc = "Harpoon Terminal (Tmux) 3", },
    { "<leader>t1", mode = "n", function() require("harpoon.term").gotoTerminal(1) end,       desc = "Harpoon Terminal 1", },
    { "<leader>t2", mode = "n", function() require("harpoon.term").gotoTerminal(2) end,       desc = "Harpoon Terminal 2", },
    { "<leader>t3", mode = "n", function() require("harpoon.term").gotoTerminal(3) end,       desc = "Harpoon Terminal 3", },
    { "<leader>hc", mode = "n", function() require('harpoon.cmd-ui').toggle_quick_menu() end, desc = "Open Harpoon CMD", },
    {
      "<leader>tc",
      mode = "n",
      function()
        local firstInput = vim.fn.input("Tmux pane number (0 To Exit)(default 1): ")
        if firstInput == "0" then
          return
        end

        local secondInput = vim.fn.input("Command number (0 To Exit)(default 1): ")
        if secondInput == "0" then
          return
        end

        if firstInput == "" then
          firstInput = "1"
        end
        if secondInput == "" then
          secondInput = "1"
        end

        if firstInput and secondInput and tonumber(firstInput) and tonumber(secondInput) then
          require('harpoon.tmux').sendCommand(tonumber(firstInput), tonumber(secondInput))
        end
      end,
      desc = "Harpoon Send CMD",
    },
  },
  config = function()
    require("telescope").load_extension("harpoon")
    require("harpoon").setup({
      global_settings = {
        enter_on_sendcmd = true,
      },
    })
  end,
}
