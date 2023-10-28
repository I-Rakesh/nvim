return {
	"iamcco/markdown-preview.nvim",
	ft = "markdown",
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	config = function()
		vim.keymap.set("n", "<C-p>", ":MarkdownPreviewToggle<CR>", { desc = "Open Markdown Preview" })
	end,
}
