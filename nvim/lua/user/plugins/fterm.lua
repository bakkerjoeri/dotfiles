local keymap = require 'lib.keymap'

keymap('n', '<leader><CR>', '<CMD>lua require("FTerm").toggle()<CR>')
keymap('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
keymap('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

require('FTerm').setup({
	dimensions = {
		width = 0.9,
		height = 0.9,
	},
})

