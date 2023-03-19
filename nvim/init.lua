-- SECTION: Key bindings
local keymap = require 'lib.keymap'

-- NOTE: Leader needs to be set before plugins are required to prevent wrong leader from being used by those plugins.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

keymap('n', '<leader>ve', ':edit ~/.config/nvim/init.lua<CR>')

keymap('n', '<leader>w', ':w<CR>')
keymap('n', '<leader>W', ':noa w<CR>')
keymap('n', '<leader>k', ':nohlsearch<CR>')

-- Window & tab management
keymap('n', '<leader>sh', '<C-w>s')
keymap('n', '<leader>sv', '<C-w>v')

keymap('n', '<A-h>', '<C-w>h')
keymap('n', '<A-j>', '<C-w>j')
keymap('n', '<A-k>', '<C-w>k')
keymap('n', '<A-l>', '<C-w>l')

keymap('n', '<A-H>', '<C-w><')
keymap('n', '<A-L>', '<C-w>>')
keymap('n', '<A-J>', '<C-w>-')
keymap('n', '<A-K>', '<C-w>+')

keymap('n', '<leader>tn', ':tabnew<CR>')
keymap('n', '<leader>tq', ':tabclose<CR>')

keymap('n', '<leader>th', ':tabprevious<CR>')
keymap('n', '<leader>tj', ':tablast<CR>')
keymap('n', '<leader>tk', ':tabfirst<CR>')
keymap('n', '<leader>tl', ':tabnext<CR>')

-- Buffer navigation
keymap('n', '<leader>bh', ':bprevious<CR>')
keymap('n', '<leader>bj', ':blast<CR>')
keymap('n', '<leader>bk', ':bfirst<CR>')
keymap('n', '<leader>bl', ':bnext<CR>')
keymap('n', '<leader>bq', ':q<CR>')

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
vim.o.title = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.number = true
vim.o.splitright = true
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.linebreak = true
vim.o.list = true
vim.o.listchars = 'tab:> ,lead:·,trail:·'
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.updatetime = 250
vim.o.showmode = false

-- SECTION: Plugins
local install_lazy = require('lib.install_lazy')
install_lazy()

require('lazy').setup({
	'jiangmiao/auto-pairs',
	'dkarter/bullets.vim',
	'tpope/vim-commentary',
	'tpope/vim-eunuch',
	'tpope/vim-fugitive',
	'tpope/vim-repeat',
	'tpope/vim-surround',
	'tpope/vim-sleuth',
	{
		'dracula/vim',
		config = function()
			vim.cmd.colorscheme 'dracula'
		end,
	},
	{
		'nvim-telescope/telescope.nvim',
		version = '*',
		dependencies = { 'nvim-lua/plenary.nvim' },
		keys = {
			{
				'<leader>/',
				function()
					require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
						winblend = 10,
						previewer = false,
					})
				end,
				desc = "[/] search in current buffer",
			},
			{ '<leader>sf', require('telescope.builtin').find_files, desc = '[s]earch [f]iles by name' },
			{ '<leader>sF', require('telescope.builtin').live_grep, desc = '[s]earch [F]iles by content' },
			{ '<leader>sw', require('telescope.builtin').grep_string, desc = '[s]earch current [w]ord' },
			{ '<leader>sb', require('telescope.builtin').buffers, desc = '[s]earch buffers' },
			{ '<leader>sd', require('telescope.builtin').diagnostics, desc = '[s]earch [d]iagnostics' },
			{ '<leader>sc', require('telescope.builtin').commands, desc = '[s]earch [c]ommands' },
			{ '<leader>sk', require('telescope.builtin').keymaps, desc = '[s]earch normal [k]eymaps' },
			{ '<leader>d', require('telescope.builtin').diagnostics, desc = 'show [d]iagnostics' },
		},
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
		end,
	},
	{
		'nvim-telescope/telescope-fzf-native.nvim',
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
			{ "<leader>f", "<cmd>NeoTreeFocusToggle<cr>", desc = "Toggle [f]ile browser" },
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
		opts = {},
	},
	{
		'akinsho/bufferline.nvim',
		lazy = false,
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
		keys = {
			{ 'gb', '<cmd>BufferLinePick<CR>', desc = '[g]o to [b]uffer' },
		},
		config = function()
			vim.opt.termguicolors = true
			require('bufferline').setup({
				options = {
					indicator = {
						icon = ' ',
						style = 'icon',
					},
					offset = {
						filetype = 'NeoTree',
						text = '  Files',
						highlight = 'BufferlineOffset',
						text_align = 'left',
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
			{ '<Leader>q', ':Sayonara!<CR>' },
		},
	},
	{
		-- LSP
		'neovim/nvim-lspconfig',
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'j-hui/fidget.nvim',
			'folke/neodev.nvim',
			'simrat39/rust-tools.nvim',
			'hrsh7th/cmp-nvim-lsp',
		},
		config = function()
			local on_attach = function(_, bufnr)
				vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
					vim.lsp.buf.format()
				end, { desc = 'Format current buffer with LSP' })
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
						on_attach = on_attach,
					})
				end,
				['eslint'] = function()
					require('lspconfig').eslint.setup({
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
		'numToStr/FTerm.nvim',
		keys = {
			{ '<leader><CR>', '<CMD>lua require("FTerm").toggle()<CR>' },
			{ '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>' },
			{ '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', mode = 't' },
		},
		config = function()
			require('FTerm').setup({
				dimensions = {
					width = 0.9,
					height = 0.9,
				},
			})
		end,
	},
	{ 'folke/which-key.nvim', opts = {} },
})
