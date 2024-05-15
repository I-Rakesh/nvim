return {
  "iamcco/markdown-preview.nvim",
  ft = "markdown",
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  config = function()
    vim.keymap.set("n", "<C-p>", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Open Markdown Preview" })
    vim.g.mkdp_auto_close = 0
  end,
}
