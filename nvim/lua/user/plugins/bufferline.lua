vim.cmd [[highlight BufferlineOffset guifg = '#80a0ff' guibg = '#21222C']]

require('bufferline').setup({
	options = {
		indicator_icon = ' ',
		offset = {
			filetype = 'NvimTree',
			text = '  Files',
			highlight = 'BufferlineOffset',
			text_align = 'left',
		},
		separator_style = 'thin',
		show_close_icon = false,
	},
})
