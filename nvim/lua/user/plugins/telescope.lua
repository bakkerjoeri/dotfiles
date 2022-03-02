local telescope = require 'telescope'
local keymap = require 'lib.keymap'

keymap('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
keymap('n', '<leader>F', [[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]])
keymap('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
keymap('n', '<leader>r', [[<cmd>lua require('telescope').extensions.live_grep_raw.live_grep_raw()<CR>]])

telescope.setup {
	defaults = {
		layout_config = {
			prompt_position = 'top',
		},
		sorting_strategy = 'ascending',
		mappings = {
			i = {
				['<C-j>'] = 'move_selection_next',
				['<C-k>'] = 'move_selection_previous',
			},
		},
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
}

require('telescope').load_extension 'fzf'
