local function setup()
  local which_key = require "which-key";
  which_key.setup({});
  which_key.register({
    ['/'] = { "<cmd>Telescope current_buffer_fuzzy_find previewer=false theme=dropdown<cr>", "Search in this buffer" },
    w = { ":w<cr>", "Write buffer" },
    k = { ":nohlsearch<cr>", "Clear search highlights" },
    d = {
      name = "Diagnostics",
      d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document diagnostics" },
      D = { "<cmd>Telescope diagnostics<cr>", "Workspace diagnostics" },
      j = {
        "<cmd>lua vim.diagnostic.goto_next()<cr>",
        "Next diagnostic",
      },
      k = {
        "<cmd>lua vim.diagnostic.goto_prev()<cr>",
        "Previous diagnostic",
      },
      l = {
        '<cmd>lua vim.diagnostic.open_float({ source = "always" })<CR>',
        "Line diagnostics"
      },
    },
    l = {
      name = "Language features",
      r = {
        "<cmd>lua vim.lsp.buf.rename()<CR>",
        "Rename symbol"
      },
      a = {  "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code actions..." },
      -- Add:
        -- format
        -- signature help
        -- hover help
        -- 
    },
    b = {
      name = "Buffer",
      g = { "<cmd>BufferLinePick<cr>", "Go to buffer..." },
      n = { ":enew<cr>", "New buffer" },
      j = { ":blast<cr>", "Go to last buffer" },
      k = { ":bfirst<cr>", "Go to first buffer" },
      h = { ":bprevious<cr>", "Go to previous buffer" },
      l = { ":bnext<cr>", "Go to next buffer" },
      w = { ":w<cr>", "Write" },
      W = { ":noa w<CR>", "Write without autocommands" },
    },
    f = {
      name = "Search",
      ['/'] = { "<cmd>Telescope current_buffer_fuzzy_find previewer=false theme=dropdown<cr>", "Search in buffer" },
      r = { "<cmd>Telescope resume<cr>", "Resume last search" },
      f = { "<cmd>Telescope find_files<cr>", "Files"},
      R = { "<cmd>Telescope oldfiles<cr>", "Recent files"},
      t = { "<cmd>Telescope live_grep<cr>", "Text"},
      w = { "<cmd>Telescope grep_string<cr>", "Current word"},
      b = { "<cmd>Telescope buffers<cr>", "Buffers"},
      d = { "<cmd>Telescope diagnostics<cr>", "Diagnostics"},
      C = { "<cmd>Telescope commands<cr>", "Commands"},
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps"},
      h = { "<cmd>Telescope help_tags<cr>", "Help" },
      c = { "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>", "Colorschemes"},
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Symbols in buffer" },
      S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Symbols in workspace" },
    },
    g = {
      name = 'Git',
      g = { "<CMD>lua LazygitToggle()<cr>", "Lazygit" },
      o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
      C = {
        "<cmd>Telescope git_bcommits<cr>",
        "Checkout commit (for current file)",
      },
      j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next hunk" },
      k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev hunk" },
      l = { "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", "Toggle blame line" },
      p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview hunk" },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset hunk" },
      R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset all" },
      s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage hunk" },
      S = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage all" },
      u = {
        "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        "Undo stage",
      },
      d = {
        "<cmd>Gitsigns diffthis HEAD<cr>",
        "Git diff",
      },
    }
  }, {
    prefix = "<leader>"
  })
end

return {
  setup = setup
}
