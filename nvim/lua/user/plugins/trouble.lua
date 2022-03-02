local trouble = require('trouble')
local keymap = require('lib.keymap')

trouble.setup {
	icons = false
}

keymap('n', '<leader>d', ':Trouble<CR>')
