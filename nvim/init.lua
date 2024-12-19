-- Key bindings
local keymap = require("lib.keymap")

-- NOTE: Leader needs to be set before plugins are required to prevent wrong leader from being used by those plugins.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<C-h>", "<C-w>h", { desc = "Go to the left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to the down window " })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to the up window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to the right window" })

keymap("n", "<C-Left>", "<C-w><", { desc = "Decrease width" })
keymap("n", "<C-Right>", "<C-w>>", { desc = "Increase width" })
keymap("n", "<C-Down>", "<C-w>-", { desc = "Decrease height" })
keymap("n", "<C-Up>", "<C-w>+", { desc = "Increase height" })

-- Move content up or down
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
keymap("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
keymap("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
keymap("v", "<A-j>", ":m '>+1<CR>gv-gv", { desc = "Move block down" })
keymap("v", "<A-k>", ":m '<-2<CR>gv-gv", { desc = "Move block up" })

-- Reselect visual selection after indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
keymap("v", "y", "myy`y")
keymap("v", "Y", "myY`y")

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- SECTION: Options
-- TODO should I remove these settings and use vim-slueth?
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.signcolumn = "yes:2"
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.clipboard = "unnamedplus"
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
vim.o.formatoptions = "cqln"

-- SECTION: Plugins
local install_lazy = require("lib.install_lazy")
install_lazy()

require("lazy").setup({
	{ import = "plugins" },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
	},
	"dkarter/bullets.vim",
	"tpope/vim-commentary",
	"tpope/vim-eunuch",
	"tpope/vim-fugitive",
	"tpope/vim-repeat",
	"tpope/vim-surround",
	"tpope/vim-sleuth",
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					layout_config = {
						prompt_position = "top",
					},
					sorting_strategy = "ascending",
					file_ignore_patterns = {},
					path_display = { "smart" },
					dynamic_preview_title = true,
					set_env = { ["COLORTERM"] = "truecolor" },
				},
				pickers = {
					find_files = {
						hidden = true,
						theme = "dropdown",
					},
					oldfiles = {
						hidden = true,
						theme = "dropdown",
					},
					live_grep = {
						hidden = true,
						ignored = true,
						theme = "dropdown",
					},
					grep_string = {
						hidden = true,
						theme = "dropdown",
					},
					buffers = {
						theme = "dropdown",
					},
					diagnostics = {
						theme = "dropdown",
					},
					commands = {
						theme = "dropdown",
					},
					keymaps = {
						theme = "dropdown",
					},
					help_tags = {
						theme = "dropdown",
					},
					colorscheme = {
						theme = "dropdown",
					},
				},
			})
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		-- NOTE: If you are having trouble with this installation,
		--       refer to the README for telescope-fzf-native for more instructions.
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},
	{
		"echasnovski/mini.files",
		version = "*",
		config = function()
			require("mini.files").setup({
				options = {
					permanent_delete = false,
				},
				windows = {
					preview = true,
				},
				mappings = {
					go_in = "<cr>",
					go_in_plus = "<S-cr>",
					go_out = "<esc>",
					go_out_plus = "<S-esc>",
				},
			})
		end,
		keys = {
			{ "<leader>e", "<cmd>:lua MiniFiles.open()<cr>", desc = "Open explorer" },
			{
				"<leader>E",
				"<cmd>:lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr><cmd>:lua MiniFiles.reveal_cwd()<cr>",
				desc = "Reveal active file in explorer",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
			require("nvim-treesitter.configs").setup({
				-- TODO add config from kickstart.nvim
				auto_install = true,
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
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				throttle = true, -- Throttles plugin updates (may improve performance)
				mode = "topline",
				max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
				patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
					-- For all filetypes
					-- Note that setting an entry here replaces all other patterns for this entry.
					-- By setting the 'default' entry below, you can control which nodes you want to
					-- appear in the context window.
					default = {
						"class",
						"function",
						"method",
					},
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({
				options = {
					disabled_filetypes = { "neo-tree", "toggleterm" },
				},
				sections = {
					lualine_a = {
						{
							"mode",
							fmt = function(str)
								return str:sub(1, 1):lower()
							end,
						},
					},
					lualine_b = { { "filename", path = 1 } },
					lualine_c = { "location", "diagnostics" },
					lualine_x = { "filetype" },
					lualine_y = { "diff", "branch" },
					lualine_z = {},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { { "filename", path = 1 } },
					lualine_x = { "branch" },
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "gb", "<cmd>BufferLinePick<CR>", desc = "Go to buffer..." },
		},
		config = function()
			require("bufferline").setup({
				options = {
					indicator = {
						icon = " ",
						style = "icon",
					},
					offsets = {
						{
							filetype = "neo-tree",
							text = "File explorer",
							text_align = "left",
							separator = true,
						},
					},
					separator_style = "thin",
					show_buffer_close_icons = false,
					show_close_icon = false,
				},
			})

			vim.cmd([[highlight BufferlineOffset guifg = '#80a0ff' guibg = '#21222C']])
		end,
	},
	{
		-- Easily quit tabs
		"jessarcher/vim-sayonara",
		keys = {
			{ "<Leader>q", ":Sayonara!<CR>", desc = "Close current buffer" },
		},
	},
	"jxnblk/vim-mdx-js",
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({})
			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float", count = 99 })
			function LazygitToggle()
				lazygit:toggle()
			end

			keymap(
				"n",
				"<C-t>",
				'<CMD>exe v:count1 . "ToggleTerm direction=horizontal"<CR>',
				{ desc = "Toggle terminal" }
			)
			keymap("t", "<C-t>", "<CMD>ToggleTerm<CR>", { desc = "Toggle terminal" })
			keymap("n", "<C-S-T>", "<CMD>ToggleTermToggleAll<CR>", { desc = "Toggle all terminals" })
			keymap("t", "<C-S-T>", "<CMD>ToggleTermToggleAll<CR>", { desc = "Toggle all terminals" })

			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			end

			-- if you only want these mappings for toggle term use term://*toggleterm#* instead
			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
		end,
	},
	-- Themes
	"dracula/vim",
	"nyoom-engineering/oxocarbon.nvim",
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "AlphaTechnolog/pywal.nvim", name = "pywal" },
})

-- Set theme
vim.cmd.colorscheme("dracula")
