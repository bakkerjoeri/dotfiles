return {
	"saghen/blink.cmp",
	dependencies = {
		"moyiz/blink-emoji.nvim",
	},
	version = "*",
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
		},
		cmdline = {
			enabled = false,
		},
	},
	opts_extend = { "sources.default" },
}
