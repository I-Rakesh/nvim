return {
  "lewis6991/gitsigns.nvim",
  event = "User FilePost",
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      numhl = true,
      word_diff = true,
      attach_to_untracked = true,
      current_line_blame = false,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]h", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[h", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        -- Actions
        map("n", "<leader>hS", gs.stage_buffer, { desc = "Git Stage Buffer" })
        map("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Git Stage Hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { desc = "Git Restore Hunk" })
        map("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Git Restore Hunk" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Git Restore Buffer" })
        map("n", "<leader>hs", gs.stage_hunk, { desc = "Git Stage Hunk" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Git Undo Staged Hunk" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Git Preview Hunk" })
        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, { desc = "Git Blame_line" })
        map("n", "<leader>htb", gs.toggle_current_line_blame, { desc = "Git Toggle Current Line Blame" })
        map("n", "<leader>hd", gs.diffthis, { desc = "Git Difftool" })
        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end, { desc = "Git Difftool ~" })
        map("n", "<leader>htd", gs.toggle_deleted, { desc = "Git Toggle Delete" })
        map("n", "<leader>htw", gs.toggle_word_diff, { desc = "Git Toggle Word Diff" })
        map("n", "<leader>htn", gs.toggle_numhl, { desc = "Git Toggle Number Highlight" })
        map("n", "<leader>hw", "<cmd>Gitsigns toggle_word_diff<CR> ", { desc = "Git Toggle Word Diff" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { silent = true, desc = "Git Select Hunk" })
      end,
    })
  end,
}
