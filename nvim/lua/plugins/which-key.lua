local function setup()
  local which_key = require "which-key";
  which_key.setup({
    icons = {
      mappings = false
    }
  });
  which_key.add({
    { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find previewer=false theme=dropdown<cr>", desc = "Search in this buffer" },
    { "<leader>b", group = "Buffer" },
    { "<leader>bW", ":noa w<CR>", desc = "Write without autocommands" },
    { "<leader>bg", "<cmd>BufferLinePick<cr>", desc = "Go to buffer..." },
    { "<leader>bh", ":bprevious<cr>", desc = "Go to previous buffer" },
    { "<leader>bj", ":blast<cr>", desc = "Go to last buffer" },
    { "<leader>bk", ":bfirst<cr>", desc = "Go to first buffer" },
    { "<leader>bl", ":bnext<cr>", desc = "Go to next buffer" },
    { "<leader>bn", ":enew<cr>", desc = "New buffer" },
    { "<leader>bw", ":w<cr>", desc = "Write" },
    { "<leader>d", group = "Diagnostics" },
    { "<leader>dD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
    { "<leader>dd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
    { "<leader>dj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next diagnostic" },
    { "<leader>dk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Previous diagnostic" },
    { "<leader>dl", '<cmd>lua vim.diagnostic.open_float({ source = "always" })<CR>', desc = "Line diagnostics" },
    { "<leader>f", group = "Search" },
    { "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find previewer=false theme=dropdown<cr>", desc = "Search in buffer" },
    { "<leader>fC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>fR", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    { "<leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Symbols in workspace" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fc", "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>", desc = "Colorschemes" },
    { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files" },
    { "<leader>fF", "<cmd>Telescope find_files no_ignore=true<cr>", desc = "Files (incl. ignored)" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume last search" },
    { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Symbols in buffer" },
    { "<leader>ft", "<cmd>Telescope live_grep<cr>", desc = "Text" },
    { "<leader>fT", "<cmd>Telescope live_grep vimgrep_arguments=rg,--no-ignore<cr>", desc = "Text (incl. ignored)" },
    { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Current word" },
    { "<leader>g", group = "Git" },
    { "<leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "Checkout commit (for current file)" },
    { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset all" },
    { "<leader>gS", "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", desc = "Stage all" },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit" },
    { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Git diff" },
    { "<leader>gg", "<CMD>lua LazygitToggle()<cr>", desc = "Lazygit" },
    { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", desc = "Next hunk" },
    { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", desc = "Prev hunk" },
    { "<leader>gl", "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", desc = "Toggle blame line" },
    { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file" },
    { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview hunk" },
    { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset hunk" },
    { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage hunk" },
    { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo stage" },
    { "<leader>k", ":nohlsearch<cr>", desc = "Clear search highlights" },
    { "<leader>l", group = "Language features" },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code actions..." },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename symbol" },
    { "<leader>w", ":w<cr>", desc = "Write buffer" },
  })
end

return {
  'folke/which-key.nvim',
  config = setup
}
