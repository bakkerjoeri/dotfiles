

-- Key bindings
local keymap = require 'lib.keymap'

-- NOTE: Leader needs to be set before plugins are required to prevent wrong leader from being used by those plugins.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

keymap('n', '<leader>ve', ':edit ~/.config/nvim/init.lua<CR>', { desc = 'Edit neovim config' })

keymap('n', '<leader>w', ':w<CR>', { desc = 'Write buffer' })
keymap('n', '<leader>W', ':noa w<CR>', { desc = 'Write without formatting' })
keymap('n', '<leader>k', ':nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Window & tab management
keymap('n', '<leader>sh', '<C-w>s', { desc = 'Split horizontally' })
keymap('n', '<leader>sv', '<C-w>v', { desc = 'Split vertically' })

keymap('n', '<A-h>', '<C-w>h', { desc = 'Go to the left window' })
keymap('n', '<A-j>', '<C-w>j', { desc = 'Go to the down window ' })
keymap('n', '<A-k>', '<C-w>k', { desc = 'Go to the up window' })
keymap('n', '<A-l>', '<C-w>l', { desc = 'Go to the right window' })

keymap('n', '<A-H>', '<C-w><', { desc = 'Decrease width' })
keymap('n', '<A-L>', '<C-w>>', { desc = 'Increase width' })
keymap('n', '<A-J>', '<C-w>-', { desc = 'Decrease height' })
keymap('n', '<A-K>', '<C-w>+', { desc = 'Increase height' })

keymap('n', '<leader>tn', ':tabnew<CR>', { desc = 'Open a new tab' })
keymap('n', '<leader>tq', ':tabclose<CR>', { desc = 'Close current tab' })

keymap('n', '<leader>th', ':tabprevious<CR>', { desc = 'Go to the previous tab' })
keymap('n', '<leader>tj', ':tablast<CR>', { desc = 'Go to the last tab' })
keymap('n', '<leader>tk', ':tabfirst<CR>', { desc = 'Go to the first tab' })
keymap('n', '<leader>tl', ':tabnext<CR>', { desc = 'Go to the next tab' })

-- Buffer navigation
keymap('n', '<leader>bh', ':bprevious<CR>', { desc = 'Go to the previous buffer' })
keymap('n', '<leader>bj', ':blast<CR>', { desc = 'Go to the last buffer' })
keymap('n', '<leader>bk', ':bfirst<CR>', { desc = 'Go to the first buffer' })
keymap('n', '<leader>bl', ':bnext<CR>', { desc = 'Go to the next buffer' })
keymap('n', '<leader>bq', ':q<CR>', { desc = 'Close current buffer' })

-- Reselect visual selection after indenting
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
keymap('v', 'y', 'myy`y')
keymap('v', 'Y', 'myY`y')

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- SECTION: Options
-- TODO should I remove these settings and use vim-slueth?
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.signcolumn = 'yes:2'
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.clipboard = 'unnamedplus'
vim.o.title = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.number = true
vim.o.splitright = true
vim.o.breakindent = true
vim.o.linebreak = true
vim.o.list = true
vim.o.listchars = 'tab:> ,lead:·,trail:·'
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.showmode = false

-- SECTION: Plugins
local install_lazy = require('lib.install_lazy')
install_lazy()

require('lazy').setup({
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {}
	},
	'dkarter/bullets.vim',
	'tpope/vim-commentary',
	'tpope/vim-eunuch',
	'tpope/vim-fugitive',
	'tpope/vim-repeat',
	'tpope/vim-surround',
	'tpope/vim-sleuth',
	'chaoren/vim-wordmotion',
	{
		'nvim-telescope/telescope.nvim',
		version = '*',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('telescope').setup({
				defaults = {
					layout_config = {
						prompt_position = 'top',
					},
					sorting_strategy = 'ascending',
					file_ignore_patterns = { '.git/' },
				},
				pickers = {
					find_files = {
						hidden = true,
					},
				},
			})
			require('telescope').load_extension('fzf')
			vim.keymap.set('n', '<leader>/', function()
				require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
					winblend = 10,
					previewer = false,
				})
			end, { desc = "Find in current buffer"})
			vim.keymap.set('n', '<leader>fr', require('telescope.builtin').resume, { desc = 'Resume last search'})
			vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Find files by content'})
			vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Find files by content'})
			vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = 'Find current word'})
			vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Find buffers'})
			vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = 'Find diagnostics'})
			vim.keymap.set('n', '<leader>fc', require('telescope.builtin').commands, { desc = 'Find commands'})
			vim.keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps, { desc = 'Find normal keymaps'})
			vim.keymap.set('n', '<leader>d', require('telescope.builtin').diagnostics, { desc = 'Show diagnostics'})
		end,
	},
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		-- NOTE: If you are having trouble with this installation,
		--       refer to the README for telescope-fzf-native for more instructions.
		build = 'make',
		cond = function()
			return vim.fn.executable 'make' == 1
		end,
	},
	{
		'nvim-neo-tree/neo-tree.nvim',
		branch = 'v2.x',
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "<leader>n", "<cmd>NeoTreeFocusToggle<cr>", desc = "Toggle file browser" },
		},
		config = function()
			require('neo-tree').setup({
				filesystem = {
					follow_current_file = true,
				}
			})
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		config = function()
			pcall(require('nvim-treesitter.install').update { with_sync = true })
			require('nvim-treesitter.configs').setup({
				-- TODO add config from kickstart.nvim
				ensure_installed = "all",
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = {
			'nvim-tree/nvim-web-devicons'
		},
		config = function()
			require('lualine').setup({
				options = {
					disabled_filetypes = {'neo-tree', 'toggleterm'},
				},
				sections = {
					lualine_a = {{
						'mode',
						fmt = function(str)
							return str:sub(1,1):lower()
						end
					}},
					lualine_b = {{'filename', path = 1}},
					lualine_c = {'location', 'diagnostics'},
					lualine_x = {'filetype'},
					lualine_y = {'diff', 'branch'},
					lualine_z = {},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {{'filename', path = 1}},
					lualine_x = {'branch'},
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},
	{
		'akinsho/bufferline.nvim',
		lazy = false,
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
		keys = {
			{ 'gb', '<cmd>BufferLinePick<CR>', desc = 'Go to buffer...' },
		},
		config = function()
			require('bufferline').setup({
				options = {
					indicator = {
						icon = ' ',
						style = 'icon',
					},
					offsets = {
						{
							filetype = 'neo-tree',
							text = '  Files',
							text_align = 'left',
							separator = true,
						}
					},
					separator_style = 'thin',
					show_buffer_close_icons = false,
					show_close_icon = false,
				},
			})

			vim.cmd [[highlight BufferlineOffset guifg = '#80a0ff' guibg = '#21222C']]
		end,
	},
	{
		-- Easily quit tabs
		'jessarcher/vim-sayonara',
		keys = {
			{ '<Leader>q', ':Sayonara!<CR>', desc = 'Close current buffer' },
		},
	},
	'jxnblk/vim-mdx-js',
	{
		-- LSP
		'neovim/nvim-lspconfig',
		dependencies = {
			'jose-elias-alvarez/null-ls.nvim',
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			{ 'j-hui/fidget.nvim', opts = {}, tag = 'legacy' },
			'folke/neodev.nvim',
			'simrat39/rust-tools.nvim',
			'hrsh7th/cmp-nvim-lsp',
		},
		config = function()
			vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
			vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
			vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
			vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

			local on_attach = function(_, bufnr)
				vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
					vim.cmd("EslintFixAll")
					vim.lsp.buf.format()
				end, { desc = 'Format current buffer with LSP' })

				vim.keymap.set('n', 'gd', ':Telescope lsp_definitions<CR>', { buffer = bufnr, desc = 'Go to definition' })
				vim.keymap.set('n', 'gy', ':Telescope lsp_type_definitions<CR>', { buffer = bufnr, desc = 'Go to type definition' })
				vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>', { buffer = bufnr, desc = 'Go to implementations' })
				vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>', { buffer = bufnr, desc = 'List references' })
				vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { buffer = bufnr, desc = 'Hover documentation' })
				vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { buffer = bufnr, desc = 'Signature documentation' })
				vim.keymap.set('n', '<C-e>', '<cmd>lua vim.diagnostic.open_float({ source = "always" })<CR>', { buffer = bufnr, desc = 'Signature documentation' })
				vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { buffer = bufnr, desc = 'Rename symbol' })
				vim.keymap.set('n', '<leader>rf', '<cmd>Format<CR>', { buffer = bufnr, desc = 'Format buffer' })
				vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { buffer = bufnr, desc = 'Code actions' })
				vim.keymap.set('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', { buffer = bufnr, desc = 'Code actions on range' })
			end

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

			-- Setup mason so it can manage external tooling
			require('mason').setup()

			-- Ensure servers above are installed
			local servers = {
				'cssls',
				'eslint',
				'html',
				'jsonls',
				'lua_ls',
				'rust_analyzer',
				'svelte',
				'tsserver',
			}

			require('mason-lspconfig').setup({
				ensure_installed = servers,
			})

			require('mason-lspconfig').setup_handlers({
				function(server_name)
					require('lspconfig')[server_name].setup({
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
					require('lspconfig').eslint.setup({
						capabilities = capabilities,
						flags = { debounce_text_changes = 150 },
						on_attach = function(client, bufnr)
							vim.api.nvim_create_autocmd("BufWritePre", {
								buffer = bufnr,
								command = "EslintFixAll"
							})
							on_attach(client, bufnr)
						end,
						filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "markdown.mdx" },
					})
				end,
				['rust_analyzer'] = function()
					require('rust-tools').setup({
						server = {
							on_attach = on_attach,
						},
						settings = {
							tools = {
								runnables = {
									use_telescope = true,
								},
								inlay_hints = {
									auto = true,
									show_parameter_hints = false,
									parameter_hints_prefix = "",
									other_hints_prefix = "",
								},
							},
						}
					})
				end,
			})

			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			require('null-ls').setup({
				capabilities = capabilities,
				flags = { debounce_text_changes = 150 },
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						-- vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
					on_attach(client, bufnr)
				end,
				sources = {
					require('null-ls').builtins.formatting.prettier.with({
						only_local = "node_modules/.bin",
						extra_filetypes = { "svelte" },
					}),
				},
			})
		end,
	},
	{
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		lazy = false,
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-nvim-lua',
			'hrsh7th/cmp-nvim-lsp-signature-help',
		},
		config = function()
			local cmp = require('cmp')
			local luasnip = require('luasnip')

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-d>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<CR>'] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					['<C-h>'] = cmp.mapping(function()
						cmp.complete()
					end, { 'i' }),
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),
				}),
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'nvim_lsp_signature_help' },
					{ name = 'nvim_lua' },
					{ name = 'luasnip' },
					{ name = 'path' },
					{ name = 'buffer' },
				},
			})
		end,
	},
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		config = function()
			require('toggleterm').setup({})
			local Terminal = require('toggleterm.terminal').Terminal
			local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float", count = 99 })
			function LazygitToggle()
				lazygit:toggle()
			end

			keymap('n', '<A-i>', '<CMD>exe v:count1 . "ToggleTerm direction=horizontal"<CR>', { desc = 'Toggle terminal' })
			keymap('t', '<A-i>', '<CMD>ToggleTerm<CR>', { desc = 'Toggle terminal' })
			keymap('n', '<A-g>', '<CMD>lua LazygitToggle()<CR>', { desc = 'Toggle lazygit' })
			keymap('t', '<A-g>', '<CMD>lua LazygitToggle()<CR>', { desc = 'Toggle lazygit' })

			function _G.set_terminal_keymaps()
				local opts = {buffer = 0}
				vim.keymap.set('t', '<A-h>', [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set('t', '<A-j>', [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set('t', '<A-k>', [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set('t', '<A-l>', [[<Cmd>wincmd l<CR>]], opts)
			end

			-- if you only want these mappings for toggle term use term://*toggleterm#* instead
			vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

		end,
	},
	{ 'folke/which-key.nvim', opts = {} },
	-- Themes
	'dracula/vim',
	'nyoom-engineering/oxocarbon.nvim',
	{ 'rose-pine/neovim', name = 'rose-pine' },
	{ "catppuccin/nvim", name = "catppuccin" },
	{ 'AlphaTechnolog/pywal.nvim', name = 'pywal' }
})

-- Set theme
vim.cmd.colorscheme 'dracula'



