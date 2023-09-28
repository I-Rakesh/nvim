vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#403b3c gui=nocombine]]

vim.opt.listchars:append "space:⋅"

require("ibl").setup {
  indent = { char = "┊" },
  scope = { enabled = false },
}
