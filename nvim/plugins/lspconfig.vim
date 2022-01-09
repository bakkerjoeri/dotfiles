Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'

function SetupNvimLsp()
lua << EOF
    local lspconfig = require("lspconfig")
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()) 

    local servers = {
        'cssls',
        'html',
        'jsonls',
        'svelte',
        'tsserver'
    }

    for i,l in ipairs(servers) do
        lspconfig[l].setup{
            capabilities = capabilities,
        }
    end
EOF

    nnoremap <silent> gd    :lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> gD    :lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> gy    :lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> gi    :lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> gr    :lua vim.lsp.buf.references()<CR>
    nnoremap <silent> ge    :lua vim.lsp.diagnostic.set_loclist()<CR>
    nnoremap <silent> K     :lua vim.lsp.buf.hover()<CR>
    nnoremap <leader>rn     :lua vim.lsp.buf.rename()<CR>
    nnoremap <leader>rf     :lua vim.lsp.buf.formatting()<CR>
    nnoremap <leader>ca     :lua vim.lsp.buf.code_action()<CR>
    xmap <leader>a          :lua vim.lsp.buf.range_code_action()<CR>
endfunction

autocmd User PlugLoaded ++nested call SetupNvimLsp()
