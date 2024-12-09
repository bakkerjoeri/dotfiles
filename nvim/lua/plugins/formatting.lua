local function setup()
	local prettier_formatter = { "prettierd", stop_after_first = true }

	require("conform").setup({
		formatters_by_ft = {
			html = prettier_formatter,
			css = prettier_formatter,
			javascript = prettier_formatter,
			javascriptreact = prettier_formatter,
			["javascript.jsx"] = prettier_formatter,
			typescript = prettier_formatter,
			typescriptreact = prettier_formatter,
			["typescript.tsx"] = prettier_formatter,
			svelte = prettier_formatter,
			vue = prettier_formatter,
			json = prettier_formatter,
			yaml = prettier_formatter,
			markdown = prettier_formatter,
			["markdown.mdx"] = prettier_formatter,
			graphql = prettier_formatter,
			lua = { "stylua" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = {
			timeout_ms = 500,
		},
		formatters = {
			prettierd = {
				require_cwd = true,
			},
		},
	})

	vim.api.nvim_create_user_command("Format", function(args)
		local range = nil
		if args.count ~= -1 then
			local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
			range = {
				start = { args.line1, 0 },
				["end"] = { args.line2, end_line:len() },
			}
		end
		require("conform").format({ async = true, lsp_format = "fallback", range = range })
	end, { range = true })

	vim.keymap.set("n", "<leader>bf", "<cmd>Format<CR>", { desc = "Format" })
end

return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = setup,
}
