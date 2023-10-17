return {
	"iamcco/markdown-preview.nvim",
	ft = "md",
	build = function()
		vim.fn["mkdp#util#install"]()
		vim.keymap.set("n", "<C-p>", ":MarkdownPreviewToggle<CR>")
	end,
}
