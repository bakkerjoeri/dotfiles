local keymap = require 'lib.keymap'

keymap('n', '<leader><CR>', ':FloatermToggle scratch<CR>')

vim.g.floaterm_width=0.8
vim.g.floaterm_height=0.8

vim.cmd([[
    " DraculaBgLight
    hi Floaterm guibg=#343746
    hi FloatermBorder guifg=#343746 guibg=#343746
]])
