return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Move focus to the left window" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Move focus to the down window" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Move focus to the up window" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Move focus to the left window" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Move focus to the previous window" },
  },
}
