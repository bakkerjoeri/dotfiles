local packer = require 'lib.packer'

packer.startup(function(use)
	use { 'wbthomason/packer.nvim' }

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
	use { 'HerringtonDarkholme/yats.vim' }
	use { 
		'jessarcher/vim-sayonara',
		config = function()
			require('user.plugins.sayonara')
		end
	}
	use { 'jxnblk/vim-mdx-js' }
	use { 'mxw/vim-jsx' }
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
