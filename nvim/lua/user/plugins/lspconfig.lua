local lspconfig = require('lspconfig')
local buf_option = vim.api.nvim_buf_set_option
local buf_keymap = require 'lib.buf_keymap'

vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

local servers = {
	'cssls',
	'eslint',
	'html',
	'jsonls',
	'tsserver',
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(_, bufnr)
	buf_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	buf_keymap(bufnr, 'n', 'gd', ':Telescope lsp_definitions<CR>')
	buf_keymap(bufnr, 'n', 'gy', ':Telescope lsp_type_definitions<CR>')
	buf_keymap(bufnr, 'n', 'gr', ':Telescope lsp_references<CR>')
	buf_keymap(bufnr, 'n', '<leader>d', ':Telescope diagnostics<CR>')
	buf_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
	buf_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
	buf_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
	buf_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
	buf_keymap(bufnr, 'n', '<leader>rf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
	buf_keymap(bufnr, 'v', '<leader>rf', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
	buf_keymap(bufnr, 'n', '<leader>ca', ':Telescope lsp_code_actions<CR>')
	buf_keymap(bufnr, 'v', '<leader>ca', ':Telescope lsp_range_code_actions<CR>')
end

for _, lsp in pairs(servers) do
	require('lspconfig')[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = { debounce_text_changes = 150 }
	}
end

vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
