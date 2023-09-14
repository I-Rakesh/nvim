vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#403b3c gui=nocombine]]

vim.opt.listchars:append "space:⋅"

require("indent_blankline").setup {
    space_char_blankline = " ",
    char = '┊',
    char_highlight_list = {
        "IndentBlanklineIndent1",
    },
}
