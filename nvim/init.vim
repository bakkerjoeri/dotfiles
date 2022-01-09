"-----------------
" General settings
"-----------------
set shiftwidth=4
set tabstop=4
set hidden
set signcolumn=yes:2
set relativenumber
set number
set splitright
set termguicolors
set clipboard+=unnamedplus
set breakindent
set linebreak
set list
set listchars=tab:>-,lead:·,trail:·
set scrolloff=8
set sidescrolloff=8
set updatetime=300 " Reduce time for highlighting other references
set redrawtime=10000 " Allow more time for loading syntax on large files

"---------
" Key maps
"---------
let mapleader = "\<space>"

nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nmap <leader>vr :source ~/.config/nvim/init.vim<cr>

nmap <leader>w :w<CR>
nmap <leader>W :noa w<CR>
nmap <leader>k :nohlsearch<CR>

" Window & tab management
nnoremap <leader>sh <C-w>s
nnoremap <leader>sv <C-w>v

nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

nnoremap <A-H> <C-w><
nnoremap <A-L> <C-w>>
nnoremap <A-J> <C-w>-
nnoremap <A-K> <C-w>+

nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tq :tabclose<CR>

nnoremap <leader>th :tabprevious<CR>
nnoremap <leader>tj :tablast<CR>
nnoremap <leader>tk :tabfirst<CR>
nnoremap <leader>tl :tabnext<CR>

" Allow gf to open non-existent files
map gf :edit <cfile><cr>

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" Maintain the cursor position when yanking a visual selection
" http://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap y myy`y
vnoremap Y myY`y

" When text is wrapped, move by terminal rows, not lines, unless a count is provided
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

"--------
" Plugins
"--------
" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugins')

source ~/.config/nvim/plugins/airline.vim
source ~/.config/nvim/plugins/coc.vim
source ~/.config/nvim/plugins/commentary.vim
source ~/.config/nvim/plugins/dracula.vim
source ~/.config/nvim/plugins/editorconfig.vim
source ~/.config/nvim/plugins/eunuch.vim
source ~/.config/nvim/plugins/fugitive.vim
source ~/.config/nvim/plugins/fzf.vim
source ~/.config/nvim/plugins/javascript.vim
source ~/.config/nvim/plugins/jsx.vim
source ~/.config/nvim/plugins/mdx.vim
source ~/.config/nvim/plugins/nerdtree.vim
source ~/.config/nvim/plugins/polyglot.vim
source ~/.config/nvim/plugins/repeat.vim
source ~/.config/nvim/plugins/sayonara.vim
source ~/.config/nvim/plugins/surround.vim
source ~/.config/nvim/plugins/svelte.vim 
source ~/.config/nvim/plugins/typescript.vim

call plug#end()
doautocmd User PlugLoaded

