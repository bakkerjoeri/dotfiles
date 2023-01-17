local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local null_ls = require('null-ls')
local buf_option = vim.api.nvim_buf_set_option
local buf_keymap = require('lib.buf_keymap')

vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format({ timeout_ms = 10000 })' ]]

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(_, bufnr)
	buf_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	buf_keymap(bufnr, 'n', 'gd', ':Telescope lsp_definitions<CR>')
	buf_keymap(bufnr, 'n', 'gy', ':Telescope lsp_type_definitions<CR>')
	buf_keymap(bufnr, 'n', 'gr', ':Telescope lsp_references<CR>')
	buf_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
	buf_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
	buf_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
	buf_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
	buf_keymap(bufnr, 'n', '<leader>rf', '<cmd>lua vim.lsp.buf.format()<CR>')
	buf_keymap(bufnr, 'v', '<leader>rf', '<cmd>lua vim.lsp.buf.range_format()<CR>')
	buf_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
	buf_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>')
end

mason.setup()
mason_lspconfig.setup({
	ensure_installed = {
		'cssls',
		'eslint',
		'html',
		'jsonls',
		'rust_analyzer',
		'svelte',
		'tsserver',
	}
})
mason_lspconfig.setup_handlers({
	function (server_name)
		lspconfig[server_name].setup({
			capabilities = capabilities,
			flags = { debounce_text_changes = 150 },
			on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
				on_attach(client, bufnr)
			end,
		})
	end,
	['eslint'] = function()
		lspconfig.eslint.setup({
			capabilities = capabilities,
			flags = { debounce_text_changes = 150 },
			on_attach = function(client, bufnr)
				vim.cmd("autocmd BufWritePre <buffer> EslintFixAll")
				on_attach(client, bufnr)
			end,
			filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "markdown.mdx" },
		})
	end,
	['rust_analyzer'] = function()
		require('rust-tools').setup({
			server = {
				on_attach = on_attach
			}
		})
	end,
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
					vim.lsp.buf.format({ timeout_ms = 10000 })
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
