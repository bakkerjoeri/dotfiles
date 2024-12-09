local lsp_servers = {
	"cssls",
	"eslint",
	"graphql",
	"html",
	"jsonls",
	"lua_ls",
	"svelte",
	"ts_ls",
	"yamlls",
}

local on_attach_lsp = function(_, bufnr)
	vim.keymap.set("n", "gd", ":Telescope lsp_definitions<CR>", { buffer = bufnr, desc = "Go to definition" })
	vim.keymap.set("n", "gy", ":Telescope lsp_type_definitions<CR>", { buffer = bufnr, desc = "Go to type definition" })
	vim.keymap.set("n", "gi", ":Telescope lsp_implementations<CR>", { buffer = bufnr, desc = "Go to implementations" })
	vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>", { buffer = bufnr, desc = "List references" })
	vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { buffer = bufnr, desc = "Hover documentation" })
	vim.keymap.set(
		"n",
		"<C-k>",
		"<cmd>lua vim.lsp.buf.signature_help()<CR>",
		{ buffer = bufnr, desc = "Signature documentation" }
	)
	vim.keymap.set(
		"n",
		"<C-e>",
		'<cmd>lua vim.diagnostic.open_float({ source = "always" })<CR>',
		{ buffer = bufnr, desc = "Line diagnostics" }
	)
	vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { buffer = bufnr, desc = "Rename symbol" })
end

local function setup()
	vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
	vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
	vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
	vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

	require("mason-lspconfig").setup({
		ensure_installed = lsp_servers,
	})
	require("mason-lspconfig").setup_handlers({
		function(server_name)
			require("lspconfig")[server_name].setup({
				on_attach = on_attach_lsp,
			})
		end,
		["eslint"] = function()
			require("lspconfig").eslint.setup({
				flags = { debounce_text_changes = 150 },
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
					on_attach_lsp(client, bufnr)
				end,
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"vue",
					"svelte",
					"markdown.mdx",
				},
			})
		end,
		["lua_ls"] = function()
			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		end,
	})
end

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		{ "j-hui/fidget.nvim", tag = "v1.0.0" },
		"williamboman/mason-lspconfig.nvim",
	},
	config = setup,
}
