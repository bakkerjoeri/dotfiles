-- Key bindings
local keymap = require 'lib.keymap'

-- NOTE: Leader needs to be set before plugins are required to prevent wrong leader from being used by those plugins.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

keymap('n', '<C-h>', '<C-w>h', { desc = 'Go to the left window' })
keymap('n', '<C-j>', '<C-w>j', { desc = 'Go to the down window ' })
keymap('n', '<C-k>', '<C-w>k', { desc = 'Go to the up window' })
keymap('n', '<C-l>', '<C-w>l', { desc = 'Go to the right window' })

keymap('n', '<C-Left>', '<C-w><', { desc = 'Decrease width' })
keymap('n', '<C-Right>', '<C-w>>', { desc = 'Increase width' })
keymap('n', '<C-Down>', '<C-w>-', { desc = 'Decrease height' })
keymap('n', '<C-Up>', '<C-w>+', { desc = 'Increase height' })

-- Move content up or down
keymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { desc = 'Move line down'});
keymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { desc = 'Move line up'});
keymap('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down'});
keymap('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up'});
keymap('v', '<A-j>', ":m '>+1<CR>gv-gv", { desc = 'Move block down'});
keymap('v', '<A-k>', ":m '<-2<CR>gv-gv", { desc = 'Move block up'});

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
vim.o.cursorline = true
vim.o.clipboard = 'unnamedplus'
vim.o.title = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.number = true
vim.o.splitright = true
vim.o.breakindent = true
vim.o.linebreak = true
vim.o.list = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.showmode = false
vim.o.formatoptions = 'cqln'

-- SECTION: Plugins
local install_lazy = require('lib.install_lazy')
install_lazy()

require('lazy').setup({
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
	},
	'dkarter/bullets.vim',
	'tpope/vim-commentary',
	'tpope/vim-eunuch',
	'tpope/vim-fugitive',
	'tpope/vim-repeat',
	'tpope/vim-surround',
	'tpope/vim-sleuth',
	{
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl',
		config = function()
			require('plugins.indentlines').setup()
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
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
					file_ignore_patterns = {},
					path_display = { 'smart' },
					dynamic_preview_title = true,
					set_env = { ["COLORTERM"] = "truecolor" },
				},
				pickers = {
					find_files = {
						hidden = true,
						theme = "dropdown"
					},
					oldfiles = {
						hidden = true,
						theme = "dropdown"
					},
					live_grep = {
						hidden = true,
						ignored = true,
						theme = "dropdown"
					},
					grep_string = {
						hidden = true,
						theme = "dropdown"
					},
					buffers = {
						theme = "dropdown"
					},
					diagnostics = {
						theme = "dropdown"
					},
					commands = {
						theme = "dropdown"
					},
					keymaps = {
						theme = "dropdown"
					},
					help_tags = {
						theme = "dropdown"
					},
					colorscheme = {
						theme = "dropdown",
					},
				},
			})
			require('telescope').load_extension('fzf')
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
			{ "<leader>e", "<cmd>NeoTreeFocusToggle<cr>", desc = "Toggle file explorer" },
		},
		config = function()
			require('neo-tree').setup({
				filesystem = {
					follow_current_file = true,
				},
				default_component_configs = {
					modified = {
						symbol = "",
						highlight = "NeoTreeModified",
					},
					git_status = {
						symbols = {
							-- Change type
							added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
							modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
							deleted   = "✖",-- this can only be used in the git_status source
							renamed   = "󰁕",-- this can only be used in the git_status source
							-- Status type
							untracked = "u",
							ignored   = "◌",
							unstaged  = "󰄱",
							staged    = "",
							conflict  = "",
						},
					},
				},
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
				indent = {
					enable = true,
					disable = { "markdown" },
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
	{
		"romgrk/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup{
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				throttle = true, -- Throttles plugin updates (may improve performance)
				mode = 'topline',
				max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
				patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
					-- For all filetypes
					-- Note that setting an entry here replaces all other patterns for this entry.
					-- By setting the 'default' entry below, you can control which nodes you want to
					-- appear in the context window.
					default = {
						'class',
						'function',
						'method',
					},
				},
			}
		end
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
							text = 'File explorer',
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
				vim.keymap.set('n', '<C-e>', '<cmd>lua vim.diagnostic.open_float({ source = "always" })<CR>', { buffer = bufnr, desc = 'Line diagnostics'})
				vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { buffer = bufnr, desc = 'Rename symbol' })
				vim.keymap.set('n', '<leader>rf', '<cmd>Format<CR>', { buffer = bufnr, desc = 'Format buffer' })
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
				'graphql',
				'html',
				'jsonls',
				'lua_ls',
				'rust_analyzer',
				'svelte',
				'tsserver',
				'yamlls'
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
				['lua_ls'] = function()
					require('lspconfig').lua_ls.setup({
						settings = {
							Lua = {
								diagnostics = {
									globals = { 'vim' }
								}
							}
						}
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
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			{
				'L3MON4D3/LuaSnip',
				version = "v2.*",
				build = "make install_jsregexp"
			},
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-nvim-lua',
			'hrsh7th/cmp-nvim-lsp-signature-help',
		},
		config = function()
			require('plugins.cmp').setup()
		end,
		event = { "InsertEnter", "CmdlineEnter" },
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

			keymap('n', '<C-t>', '<CMD>exe v:count1 . "ToggleTerm direction=horizontal"<CR>', { desc = 'Toggle terminal' })
			keymap('t', '<C-t>', '<CMD>ToggleTerm<CR>', { desc = 'Toggle terminal' })
			keymap('n', '<C-S-T>', '<CMD>ToggleTermToggleAll<CR>', { desc = 'Toggle all terminals' })
			keymap('t', '<C-S-T>', '<CMD>ToggleTermToggleAll<CR>', { desc = 'Toggle all terminals' })

			function _G.set_terminal_keymaps()
				local opts = {buffer = 0}
				vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
			end

			-- if you only want these mappings for toggle term use term://*toggleterm#* instead
			vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
		end,
	},
	{
		'folke/which-key.nvim',
		config = function()
			require('plugins.which-key').setup()
		end,
	},
	-- Themes
	'dracula/vim',
	'nyoom-engineering/oxocarbon.nvim',
	{ 'rose-pine/neovim', name = 'rose-pine' },
	{ "catppuccin/nvim", name = "catppuccin" },
	{ 'AlphaTechnolog/pywal.nvim', name = 'pywal' }
})

-- Set theme
vim.cmd.colorscheme 'dracula'
