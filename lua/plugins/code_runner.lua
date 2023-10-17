return {
  "CRAG666/code_runner.nvim",
  event = "VeryLazy",
  config = function()
    require("code_runner").setup({
      filetype = {
        java = {
          "cd $dir &&",
          "javac $fileName &&",
          "java $fileNameWithoutExt",
        },
        python = "python3 -u",
        typescript = "deno run",
        rust = {
          "cd $dir &&",
          "rustc $fileName &&",
          "$dir/$fileNameWithoutExt",
        },
        c = {
          "cd $dir &&",
          "gcc -o $fileNameWithoutExt $fileName &&",
          "$dir/$fileNameWithoutExt",
        },
        cpp = {
          "cd $dir &&",
          "g++ -o $fileNameWithoutExt $fileName &&",
          "$dir/$fileNameWithoutExt",
        },
        sh = {
          "cd $dir &&",
          "chmod +x $fileName &&",
          "./$fileName",
        },
      },
      mode = "float",
      float = {
        border = "single",
        height = 0.5,
        width = 0.5,
        x = 0.5,
        y = 0.5,
        border_hl = "Normal",
      },
    })

    vim.keymap.set("n", "<leader>rr", ":RunFile term<CR>", { noremap = true, silent = false })
    vim.keymap.set("n", "<leader>rf", ":RunFile float<CR>", { noremap = true, silent = false })
    vim.keymap.set("n", "<leader>rt", ":RunFile tab<CR>", { noremap = true, silent = false })
    vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = false })
    vim.keymap.set("n", "<leader>rx", ":RunClose<CR>", { noremap = true, silent = false })
    vim.keymap.set("n", "<leader>rcf", ":CRFiletype<CR>", { noremap = true, silent = false })
    vim.keymap.set("n", "<leader>rcp", ":CRProjects<CR>", { noremap = true, silent = false })
  end,
}
