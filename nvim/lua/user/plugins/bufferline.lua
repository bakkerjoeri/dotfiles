local keymap = require('lib.keymap')

vim.cmd [[highlight BufferlineOffset guifg = '#80a0ff' guibg = '#21222C']]

require('bufferline').setup({
	options = {
		indicator = {
			icon = ' ',
			style = 'icon',
		},
		offset = {
			filetype = 'NvimTree',
			text = '  Files',
			highlight = 'BufferlineOffset',
			text_align = 'left',
		},
		separator_style = 'thin',
		show_buffer_close_icons = false,
		show_close_icon = false,
	},
})

keymap('n', 'gb', ':BufferLinePick<CR>')
