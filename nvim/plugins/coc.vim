Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'

"-----------------
" Language servers
"-----------------
let g:coc_global_extensions = [
    \ 'coc-css',
    \ 'coc-eslint',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-phpls',
    \ 'coc-prettier',
    \ 'coc-svelte',
    \ 'coc-svg',
    \ 'coc-tsserver',
\ ]

"--------
" Keymaps
"--------
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> <leader>d :CocFzfList diagnostics<CR>
nmap <silent> [g <Plug>(coc-diagnostics-prev)
nmap <silent> ]g <Plug>(coc-diagnostics-next)
nmap <silent> K :call CocAction('doHover')<CR>
nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>rf :call CocAction('format')<CR>
vmap <silent> <leader>rf <Plug>(coc-format-selected)
nmap <leader>ca <Plug>(coc-codeaction)

"---------
" Commands
"---------
command! -nargs=0 Format :call CocAction('format')
