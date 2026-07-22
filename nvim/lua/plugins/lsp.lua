local lsp_servers = {
	"cssls",
	"eslint",
	"html",
	"jsonls",
	"lua_ls",
	"svelte",
	"ts_ls",
	"yamlls",
}

local set_lsp_keymaps = function(bufnr)
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
end

local set_lsp_diagnostic_signs = function()
	vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
	vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
	vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
	vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
end

local function setup()
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = lsp_servers,
		automatic_enable = true,
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local bufnr = args.buf
			set_lsp_keymaps(bufnr)
			set_lsp_diagnostic_signs()
		end,
	})
end

return {
	"neovim/nvim-lspconfig",
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = setup,
	},
	"j-hui/fidget.nvim",
}
