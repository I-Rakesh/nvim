return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = {
    -- stylua: ignore
    { "<leader>sf", mode = "n", "<cmd>Telescope find_files<CR>", desc = "Search files" },
    { "<leader>sw", mode = "n", "<cmd>Telescope live_grep<CR>", desc = "Search Word" },
    {
      "<leader>sb",
      mode = "n",
      "<cmd>Telescope buffers sort_mru=true<CR>",
      desc = "Search Buffer",
    },
    { "<leader>st", mode = "n", "<cmd>Telescope help_tags<CR>", desc = "Search Help Tags" },
    { "<leader>sk", mode = "n", "<cmd>Telescope keymaps<CR>", desc = "Search Keymaps" },
    { "<leader>sg", mode = "n", "<cmd>Telescope git_status<CR>", desc = "Search Git status" },
    { "<leader>ch", mode = "n", "<cmd>Telescope colorscheme<CR>", desc = "Change Color Scheme" },
    { "<leader>sdw", mode = "n", "<cmd>Telescope diagnostics<CR>", desc = "Search Workspace Diagnostics" },
    { "<leader>sdb", mode = "n", "<cmd>Telescope diagnostics bufnr=0<CR>", desc = "Search Diagnostics" },
    { "<leader>sr", mode = "n", "<cmd>Telescope lsp_references<CR>", desc = "Search References" },
    { "<leader>ssb", mode = "n", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Search Symbles" },
    {
      "<leader>ssw",
      mode = "n",
      "<cmd>Telescope lsp_dynamic_workspace_symbols <CR>",
      desc = "Search Workspace Symbles",
    },
    { "<leader>sj", mode = "n", "<cmd>Telescope jumplist<CR>", desc = "Search Jumplist" },
    { "<leader>sm", mode = "n", "<cmd>Telescope marks<CR>", desc = "Search Marks" },
    { "<leader>so", mode = "n", "<cmd>Telescope oldfiles<CR>", desc = "Search Old Files" },
    { "<leader>s*", mode = "n", "<cmd>Telescope grep_string<CR>", desc = "Search Current Word" },
    { "<leader>s:", mode = "n", "<cmd>Telescope command_history<CR>", desc = "Search Command History" },
    { "<leader>sp", mode = "n", "<cmd>Telescope resume<CR>", desc = "Previous Search" },
    { "<leader>z", mode = "n", "<cmd>Telescope spell_suggest<CR>", desc = "Search Spell Suggestion's" },
    {
      "<leader>sc",
      mode = "n",
      function()
        require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Search Neovim Config",
    },
    {
      "<leader>s/",
      mode = "n",
      function()
        require("telescope.builtin").live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        })
      end,
      desc = "Search Word in Current Buffer",
    },
    {
      "<leader>sw",
      mode = "v",
      function()
        vim.cmd(':normal! "sy')
        local selected_text = vim.fn.getreg("s")
        local escaped_text = vim.fn.escape(selected_text, " ")
        vim.cmd(":Telescope live_grep default_text=" .. escaped_text)
      end,
      desc = "Search Highlighted Word",
    },
    {
      "<leader>s/",
      mode = "v",
      function()
        vim.cmd(':normal! "sy')
        local selected_text = vim.fn.getreg("s")
        local escaped_text = vim.fn.escape(selected_text, " ")
        vim.cmd(":Telescope live_grep grep_open_files=ture default_text=" .. escaped_text)
      end,
      desc = "Search Highlighted Word in Current Buffer",
    },
  },
  config = function()
    vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")
    local actions = require("telescope.actions")

    require("telescope").setup({
      pickers = {
        find_files = {
          path_display = {
            filename_first = {
              reverse_directories = false,
            },
          },
        },
        git_files = {
          path_display = {
            filename_first = {
              reverse_directories = false,
            },
          },
        },
        buffers = {
          path_display = {
            filename_first = {
              reverse_directories = false,
            },
          },
          mappings = {
            n = {
              ["x"] = actions.delete_buffer,
            },
          },
        },
        oldfiles = {
          path_display = {
            filename_first = {
              reverse_directories = false,
            },
          },
        },
        colorscheme = {
          enable_preview = true,
        },
      },
      defaults = {
        mappings = {
          n = {
            ["<leader>q"] = actions.smart_send_to_qflist + actions.open_qflist,
            ["<A-Down>"] = actions.cycle_history_next,
            ["<A-Up>"] = actions.cycle_history_prev,
          },
          i = {
            ["<A-Down>"] = actions.cycle_history_next,
            ["<A-Up>"] = actions.cycle_history_prev,
          },
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        file_ignore_patterns = {
          "node_modules",
        },
        prompt_prefix = "  ",
        selection_caret = "󰁕 ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
      },
    })
    require("telescope").load_extension("fzf")
  end,
}
