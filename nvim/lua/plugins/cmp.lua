return {
	"saghen/blink.cmp",
	dependencies = {
		"jdrupal-dev/css-vars.nvim",
		"saghen/blink.lib",
	},
	branch = "main",
	build = function()
		require("blink.cmp").build():pwait()
	end,
	opts = {
		keymap = {
			preset = "default",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<CR>"] = { "accept", "fallback" },
		},
		signature = { enabled = true },
		completion = {
			trigger = {
				show_on_trigger_character = true,
				show_on_accept_on_trigger_character = true,
			},
			list = {
				selection = {
					preselect = false,
				},
			},
			menu = {
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind", "source_name", gap = 1 },
					},
				},
			},
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			per_filetype = {
				css = { "css_vars", inherit_defaults = true },
				scss = { "css_vars", inherit_defaults = true },
				less = { "css_vars", inherit_defaults = true },
				javascript = { "css_vars", inherit_defaults = true },
				javascriptreact = { "css_vars", inherit_defaults = true },
				typescript = { "css_vars", inherit_defaults = true },
				typescriptreact = { "css_vars", inherit_defaults = true },
				svelte = { "css_vars", inherit_defaults = true },
			},
			providers = {
				css_vars = {
					name = "css-vars",
					module = "css-vars.blink",
					opts = {
						search_extensions = { ".css", ".scss", ".less", ".svelte", ".js", ".jsx", ".ts", ".tsx" },
					},
					enabled = function()
						if vim.bo.filetype ~= "svelte" then
							return true
						end

						-- Svelte mixes script/markup/style in one buffer under a
						-- single filetype, so per_filetype can't scope this to
						-- just <style>. Use the treesitter tree at the cursor to
						-- check we're actually inside an injected css/scss/less
						-- region instead.
						local ok, parser = pcall(vim.treesitter.get_parser)
						if not ok or not parser then
							return false
						end

						local cursor = vim.api.nvim_win_get_cursor(0)
						local row, col = cursor[1], cursor[2]
						local lang = parser:language_for_range({ row - 1, col, row - 1, col }):lang()

						-- Svelte's own grammar parses the whole markup body (tags,
						-- attributes, text) as language "svelte" itself - there is
						-- no separate "html" injection for the template, only for
						-- things like inline style="" attributes (injected as css)
						-- or {expr} mustache tags (injected as javascript). So the
						-- markup case we actually want to match is "svelte", not
						-- "html".
						return vim.tbl_contains({ "svelte", "html", "css", "scss", "less" }, lang)
					end,
				},
			},
		},
		cmdline = {
			enabled = false,
		},
	},
	opts_extend = { "sources.default" },
}
