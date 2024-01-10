local build_commands = {
  c = "!g++ -std=c++17 -o %:p:r.o %",
  cpp = "!g++ -std=c++17 -Wall -O2 -o %:p:r.o %",
  rust = "!cargo build --release",
  go = "!go build",
  -- tex = "pdflatex %",
  tex = "VimtexCompile",
  javascript = "",
  java = "!javac %",
  sh = "!chmod +x %",
}

local debug_build_commands = {
  c = "!g++ -std=c++17 -g -o %:p:r.o %",
  cpp = "!g++ -std=c++17 -g -o %:p:r.o %",
  rust = "!cargo build",
  go = "!go build",
}

local run_commands = {
  c = "%:p:r.o",
  cpp = "%:p:r.o",
  rust = "cargo run --release",
  -- go = "%:p:r.o",
  go = "go run .",
  -- tex = "open %:p:r.pdf",
  tex = "",
  javascript = "node %",
  java = "java %",
  python = "python3 %",
  html = "open %",
  sh = "./%",
}

vim.api.nvim_create_user_command("Build", function()
  local filetype = vim.bo.filetype

  for file, command in pairs(build_commands) do
    if filetype == file then
      vim.cmd("silent " .. command)
      break
    end
  end
end, {})

vim.api.nvim_create_user_command("DebugBuild", function()
  local filetype = vim.bo.filetype

  for file, command in pairs(debug_build_commands) do
    if filetype == file then
      vim.cmd("silent " .. command)
      break
    end
  end
end, {})

vim.api.nvim_create_user_command("Run", function()
  local filetype = vim.bo.filetype

  for file, command in pairs(run_commands) do
    if filetype == file then
      vim.cmd("sp")
      vim.cmd("term " .. command)
      vim.cmd("resize 15")
      local keys = vim.api.nvim_replace_termcodes("i", true, false, true)
      vim.api.nvim_feedkeys(keys, "n", false)
      break
    end
  end
end, {})

vim.api.nvim_create_user_command("Ha", function()
  vim.cmd([[Build]])
  vim.cmd([[Run]])
end, {})

--Keymaps
vim.keymap.set("n", "<leader>rr", "<cmd>Ha<CR>", { desc = "Run Current file" })
vim.keymap.set("n", "<leader>rb", "<cmd>Build<CR><cmd>echo 'Building file'<CR>", { desc = "Build Current file" })
-- stylua: ignore
vim.keymap.set("n", "<leader>rd", "<cmd>DebugBuild<CR><cmd>echo 'DebugBuild file'<CR>",
  { desc = "DebugBuild Current file" })

local M = {}

M.lazy_load = function(plugin)
  vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
    callback = function()
      local file = vim.fn.expand("%")
      local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

      if condition then
        vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

        if plugin ~= "nvim-treesitter" then
          vim.schedule(function()
            require("lazy").load({ plugins = plugin })

            if plugin == "nvim-lspconfig" then
              vim.cmd("silent! do FileType")
            end
          end, 0)
        else
          require("lazy").load({ plugins = plugin })
        end
      end
    end,
  })
end

return M
