local lspconfig = require('lspconfig')
local null_ls = require('null-ls')
local buf_option = vim.api.nvim_buf_set_option
local buf_keymap = require('lib.buf_keymap')

vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(_, bufnr)
	buf_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	buf_keymap(bufnr, 'n', 'gd', ':Telescope lsp_definitions<CR>')
	buf_keymap(bufnr, 'n', 'gy', ':Telescope lsp_type_definitions<CR>')
	buf_keymap(bufnr, 'n', 'gr', ':Telescope lsp_references<CR>')
	buf_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
	buf_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
	buf_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
	buf_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
	buf_keymap(bufnr, 'n', '<leader>rf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
	buf_keymap(bufnr, 'v', '<leader>rf', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
	buf_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
	buf_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>')
end

for _, lsp in pairs({
	'cssls',
	'html',
	'jsonls',
	'svelte',
	'tsserver',
}) do
	lspconfig[lsp].setup({
		capabilities = capabilities,
		flags = { debounce_text_changes = 150 },
		on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
			on_attach(client, bufnr)
		end,
	})
end

lspconfig.eslint.setup({
	capabilities = capabilities,
	flags = { debounce_text_changes = 150 },
	on_attach = function(client, bufnr)
		vim.cmd("autocmd BufWritePre <buffer> EslintFixAll")
		on_attach(client, bufnr)
	end,
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "markdown.mdx" },
})

null_ls.setup({
	capabilities = capabilities,
	flags = { debounce_text_changes = 150 },
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.formatting_sync()
				end,
			})
		end
	end,
	sources = {
		null_ls.builtins.formatting.prettier.with({
			only_local = "node_modules/.bin",
			extra_filetypes = { "svelte" },
		}),
	},
})

vim.fn.sign_define('DiagnosticSignError', { text = '✖', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '⚠', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '•', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '•', texthl = 'DiagnosticSignHint' })
