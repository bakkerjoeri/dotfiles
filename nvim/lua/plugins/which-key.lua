local function setup()
  local which_key = require "which-key";
  which_key.setup({});
  which_key.register({
    g = {
      name = 'Git',
      g = { "<CMD>lua LazygitToggle()<CR>", "Lazygit" },
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
