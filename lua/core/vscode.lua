if not vim.g.vscode then
  return {}
end

-- Option's
vim.opt.spell = false

local enabled = {
  "flash.nvim",
  "Comment.nvim",
  "nvim-treesitter",
  "nvim-treesitter-textobjects",
  "nvim-ts-context-commentstring",
  "nvim-treesitter-refactor",
  "vim-repeat",
  "vim-surround",
  "LazyVim",
}

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  defaults = {
    cond = function(plugin)
      return vim.tbl_contains(enabled, plugin.name)
    end,
  },
  checker = {
    enabled = false, -- automatically check for plugin updates
  },
  change_detection = {
    enabled = false,
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "2html_plugin",
        "ftplugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
      },
    },
  },
})

-- Keymaps
vim.keymap.set("n", "<leader>sf", "<cmd>Find<cr>")
vim.keymap.set("n", "<leader>/", [[<cmd>call VSCodeNotify('workbench.action.findInFiles')<cr>]])
vim.keymap.set("n", "<leader>ss", [[<cmd>call VSCodeNotify('workbench.action.gotoSymbol')<cr>]])
vim.keymap.set("n", "<leader>sb", [[<cmd>call VSCodeNotify('workbench.action.showAllEditors')<cr>]])
vim.keymap.set("n", "<leader>bm", [[<cmd>call VSCodeNotify('editor.debug.action.toggleInlineBreakpoint')<cr>]])
vim.keymap.set("n", "<leader>rr", [[<cmd>call VSCodeNotify('code-runner.run')<cr>]])
vim.keymap.set("n", "<leader>tj", [[<cmd>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<cr>]])
vim.keymap.set("n", "<leader>x", [[<cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<cr>]])
vim.keymap.set("n", "<C-h>", [[<cmd>call VSCodeNotify('workbench.action.navigateLeft')<cr>]])
vim.keymap.set("n", "<C-l>", [[<cmd>call VSCodeNotify('workbench.action.navigateRight')<cr>]])
vim.keymap.set("n", "<C-j>", [[<cmd>call VSCodeNotify('workbench.action.navigateDown')<cr>]])
vim.keymap.set("n", "<C-k>", [[<cmd>call VSCodeNotify('workbench.action.navigateUp')<cr>]])
vim.keymap.set("n", "-", [[<cmd>call VSCodeNotify('workbench.view.explorer')<cr>]])
vim.keymap.set("n", "<leader>gs", [[<cmd>call VSCodeNotify('workbench.view.scm')<cr>]])
vim.keymap.set(
  "n",
  "<leader>'",
  [[<cmd>call VSCodeNotify('workbench.action.toggleEditorGroupLayout')<cr> <cmd>call VSCodeNotify('workbench.action.focusPreviousGroup')<cr>]]
)
