return {
	"folke/flash.nvim",
	opts = {},
  -- stylua: ignore
  keys = {
    { "/" },
    { "?" },
    { "f",     mode = { "n", "v" } },
    { "F",     mode = { "n", "v" } },
    { "t",     mode = { "n", "v" } },
    { "T",     mode = { "n", "v" } },
    { "s",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
  },
}
