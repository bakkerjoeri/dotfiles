local ensure_installed = {
	"astro",
	"bash",
	"css",
	"editorconfig",
	"graphql",
	"html",
	"javascript",
	"jsdoc",
	"json",
	"kitty",
	"lua",
	"markdown",
	"php",
	"python",
	"rust",
	"sql",
	"svelte",
	"sway",
	"typescript",
	"vim",
	"yaml",
	"zsh",
}
local should_highlight = true
local should_auto_install = true
local should_indent = true
local should_enable_folds = false

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install(ensure_installed)

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(filetypeEvent)
				local language = vim.treesitter.language.get_lang(filetypeEvent.match)
				local available_languages = require("nvim-treesitter").get_available()
				local is_language_available = vim.tbl_contains(available_languages, language)

				if not is_language_available then
					return
				end

				local is_language_installed = vim.tbl_contains(require("nvim-treesitter").get_installed(), language)
				if not is_language_installed and should_auto_install then
					require("nvim-treesitter").install(language):wait()
				end

				if should_highlight then
					vim.treesitter.start()
				end

				if should_indent then
					require("nvim-treesitter").indentexpr()
				end

				if should_enable_folds then
					vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo[0][0].foldmethod = "expr"
				end
			end,
		})
	end,
}
