local keymap = require 'lib.keymap'

vim.g.mapleader = ' '

keymap('n', '<leader>ve', ':edit ~/.config/nvim/init.lua<CR>')

keymap('n', '<leader>w', ':w<CR>')
keymap('n', '<leader>W', ':noa w<CR>')
keymap('n', '<leader>k', ':nohlsearch<CR>')

-- Window & tab management
keymap('n', '<leader>sh', '<C-w>s')
keymap('n', '<leader>sv', '<C-w>v')

keymap('n', '<A-h>', '<C-w>h')
keymap('n', '<A-j>', '<C-w>j')
keymap('n', '<A-k>', '<C-w>k')
keymap('n', '<A-l>', '<C-w>l')

keymap('n', '<A-H>', '<C-w><')
keymap('n', '<A-L>', '<C-w>>')
keymap('n', '<A-J>', '<C-w>-')
keymap('n', '<A-K>', '<C-w>+')

keymap('n', '<leader>tn', ':tabnew<CR>')
keymap('n', '<leader>tq', ':tabclose<CR>')

keymap('n', '<leader>th', ':tabprevious<CR>')
keymap('n', '<leader>tj', ':tablast<CR>')
keymap('n', '<leader>tk', ':tabfirst<CR>')
keymap('n', '<leader>tl', ':tabnext<CR>')

-- Buffer navigation
keymap('n', '<leader>bh', ':bprevious<CR>')
keymap('n', '<leader>bj', ':blast<CR>')
keymap('n', '<leader>bk', ':bfirst<CR>')
keymap('n', '<leader>bl', ':bnext<CR>')

-- Allow gf to open non-existent files
keymap('', 'gf', ':edit <cfile><cr>')

-- Reselect visual selection after indenting
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
keymap('v', 'y', 'myy`hay')
keymap('v', 'Y', 'myY`y')

-- Copy using the machine register
keymap('n', '<C-c>', ':\'<,\'>w !xclip -i -sel c<CR><CR>')

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
