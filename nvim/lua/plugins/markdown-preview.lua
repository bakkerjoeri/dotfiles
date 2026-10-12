return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
		vim.g.mkdp_auto_close = 0
		vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<CR>", { desc = "Markdown preview" })
	end,
	ft = { "markdown" },
}
