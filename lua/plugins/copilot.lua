return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  -- stylua: ignore
  keys = {
    { "<leader>cp", mode = "n", ToggleCopilot, desc = "Copilot Toggle", },
  },
  config = function()
    function ToggleCopilot()
      local client = vim.lsp.get_active_clients({ name = "copilot" })[1]
      if client == nil then
        vim.cmd("Copilot enable")
        vim.cmd("echo 'Copilot enabled'")
      else
        vim.cmd("Copilot disable")
        vim.cmd("echo 'Copilot disabled'")
      end
    end

    vim.keymap.set("n", "<leader>cp", ToggleCopilot, { desc = "Copilot Toggle" })
    vim.keymap.set(
      "n",
      "<leader>cs",
      "<cmd>Copilot suggestion toggle_auto_trigger<cr><cmd>echo 'Copilot  Toggle'<CR>",
      { desc = "Copilot Toggle Suggestion" }
    )
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-Space>",
          accept_word = "<C-w>",
          accept_line = "<C-l>",
        },
      },
      filetypes = {
        markdown = true,
        help = true,
      },
    })
  end,
}
