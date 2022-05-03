local packer = require 'lib.packer'

packer.startup(function(use)
	use { 'wbthomason/packer.nvim' }
	use {
		'akinsho/bufferline.nvim',
		requires = 'kyazdani42/nvim-web-devicons',
		config = function()
			require('user.plugins.bufferline')
		end
  }
	use {
		'dracula/vim',
		as = 'dracula',
		config = function()
			require 'user.plugins.dracula'
		end
	}
	use { 'editorconfig/editorconfig-vim' }
	use {
		'evanleck/vim-svelte',
		config = function()
			require('user.plugins.svelte')
		end
	}
	use {
		'folke/trouble.nvim',
		config = function()
			require('user.plugins.trouble')
		end
	}
	use { 'HerringtonDarkholme/yats.vim' }
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-nvim-lua',
			'hrsh7th/cmp-nvim-lsp-signature-help',
			'saadparwaiz1/cmp_luasnip',
			'L3MON4D3/LuaSnip',
		},
		config = function()
			require('user.plugins.cmp')
		end
	}
	use { 
		'jessarcher/vim-sayonara',
		config = function()
			require('user.plugins.sayonara')
		end
	}
	use { 'jxnblk/vim-mdx-js' }
	use {
		'kyazdani42/nvim-tree.lua',
		requires = 'kyazdani42/nvim-web-devicons',
		config = function()
			require('user.plugins.nvim-tree')
		end
	}
	use { 'mxw/vim-jsx' }
	use {
		'neovim/nvim-lspconfig',
		requires = {
			'jose-elias-alvarez/null-ls.nvim',
		},
		config = function()
			require('user.plugins.lspconfig')
		end
	}
	use {
		'numToStr/FTerm.nvim',
		config = function()
			require('user.plugins.fterm')
		end
	}
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = function()
			require('user.plugins.lualine')
		end
	}
	use {
		'nvim-telescope/telescope.nvim',
		requires = {
			{ 'nvim-lua/plenary.nvim' },
			{ 'kyazdani42/nvim-web-devicons' },
			{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
			{ 'nvim-telescope/telescope-live-grep-raw.nvim' },
		},
		config = function()
			require('user.plugins.telescope')
		end
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require('user.plugins.treesitter')
		end
	}
	use { 'pangloss/vim-javascript' }
	use { 'tpope/vim-commentary' }
	use { 'tpope/vim-eunuch' }
	use {
		'tpope/vim-fugitive',
		requires = 'tpope/vim-rhubarb',
		cmd = 'G',
	}
	use { 'tpope/vim-repeat' }
	use { 'tpope/vim-surround' }
end)
