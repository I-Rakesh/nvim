local M = {}

-- Terminal
vim.cmd([[autocmd TermOpen * setlocal nonumber norelativenumber nospell signcolumn=no ]])

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- don't auto comment new line
vim.api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- go to last loc when opening a buffer
-- this mean that when you open a file, you will be at the last position
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

--Function to toggle quickfix window
vim.g.quickfix_opened = 0
function ToggleQuickfix()
  local wininfo = vim.fn.getwininfo()
  if vim.tbl_isempty(vim.fn.filter(wininfo, "v:val.quickfix")) then
    vim.cmd(":copen")
    vim.g.quickfix_opened = 1
  else
    vim.cmd(":cclose")
    vim.g.quickfix_opened = 0
  end
end

vim.api.nvim_set_keymap(
  "n",
  "<leader>q",
  "<cmd>lua ToggleQuickfix()<CR>",
  { noremap = true, silent = true, desc = "Toggle Quickfix list" }
)

--Change Default register to selected registers Youtube-video(https://youtu.be/cz01rOOaLmA?si=7uNqwz0te4UU8zRs) gitbub()https://github.com/Axlefublr/dotfiles/blob/c2a3cabd4aa11a66da714f2c8c620e5b24e86e44/neovim/big.lua

function GetChar(prompt)
  vim.api.nvim_echo({ { prompt, "Input" } }, true, {})
  local char = vim.fn.getcharstr()
  -- That's the escape character (<Esc>). Not sure how to specify it smarter
  -- In other words, if you pressed escape, we return nil
  if char == "" then
    char = nil
  end
  return char
end

function Move_default_to_other()
  local char = GetChar("Register: ")
  if not char then
    return
  end
  local default_contents = vim.fn.getreg('"')
  vim.fn.setreg(char, default_contents)
end

vim.keymap.set("n", ",g", Move_default_to_other)

--Numbered Registers

local numbered = setmetatable({ "", "", "", "", "", "", "", "", "", "" }, { __index = table })

local function numbered_get(index)
  if numbered[index] == "" then
    print(index .. " is empty")
    return
  end
  vim.fn.setreg('"', numbered[index])
  print("grabbed")
end

local function numbered_set(index)
  local register_contents = vim.fn.getreg('"')
  if register_contents == "" then
    print("default register empty")
    return
  end
  numbered[index] = register_contents
  print("stabbed")
end

vim.keymap.set({ "n", "v" }, "'1", function()
  numbered_get(1)
end)
vim.keymap.set({ "n", "v" }, "'2", function()
  numbered_get(2)
end)
vim.keymap.set({ "n", "v" }, "'3", function()
  numbered_get(3)
end)
vim.keymap.set({ "n", "v" }, "'4", function()
  numbered_get(4)
end)
vim.keymap.set({ "n", "v" }, "'5", function()
  numbered_get(5)
end)
vim.keymap.set({ "n", "v" }, "'6", function()
  numbered_get(6)
end)
vim.keymap.set({ "n", "v" }, "'7", function()
  numbered_get(7)
end)
vim.keymap.set({ "n", "v" }, "'8", function()
  numbered_get(8)
end)
vim.keymap.set({ "n", "v" }, "'9", function()
  numbered_get(9)
end)
vim.keymap.set({ "n", "v" }, "'0", function()
  numbered_get(10)
end)

vim.keymap.set({ "n", "v" }, ",1", function()
  numbered_set(1)
end)
vim.keymap.set({ "n", "v" }, ",2", function()
  numbered_set(2)
end)
vim.keymap.set({ "n", "v" }, ",3", function()
  numbered_set(3)
end)
vim.keymap.set({ "n", "v" }, ",4", function()
  numbered_set(4)
end)
vim.keymap.set({ "n", "v" }, ",5", function()
  numbered_set(5)
end)
vim.keymap.set({ "n", "v" }, ",6", function()
  numbered_set(6)
end)
vim.keymap.set({ "n", "v" }, ",7", function()
  numbered_set(7)
end)
vim.keymap.set({ "n", "v" }, ",8", function()
  numbered_set(8)
end)
vim.keymap.set({ "n", "v" }, ",9", function()
  numbered_set(9)
end)
vim.keymap.set({ "n", "v" }, ",0", function()
  numbered_set(10)
end)

--Killring copied from Youtube-video(https://youtu.be/KCx4mwhXffk?si=g2FJVAhWoJm5RJdk) github(https://github.com/Axlefublr/dotfiles/blob/03f0037c0734bdafaa57ee123d42556f817be84b/neovim/registers/killring.lua)

local killring = setmetatable({}, { __index = table })

local function killring_push_tail()
  local register_contents = vim.fn.getreg('"')
  if register_contents == "" then
    print("default register is empty")
    return
  end
  killring:insert(1, register_contents)
  print("pushed")
end
vim.keymap.set("n", ",R", killring_push_tail, { desc = "Killring Add at first" })

local function killring_push()
  local register_contents = vim.fn.getreg('"')
  if register_contents == "" then
    print("default register is empty")
    return
  end
  killring:insert(register_contents)
  print("pushed")
end
vim.keymap.set("n", ",r", killring_push, { desc = "Killring Add at last" })

local function killring_pop_tail()
  if #killring <= 0 then
    print("killring empty")
    return
  end
  local first_index = killring:remove(1)
  vim.fn.setreg('"', first_index)
  print("got tail")
end
vim.keymap.set("n", ",E", killring_pop_tail, { desc = "Killring take from top" })

local function killring_pop()
  if #killring <= 0 then
    print("killring empty")
    return
  end
  local first_index = killring:remove(#killring)
  vim.fn.setreg('"', first_index)
  print("got nose")
end
vim.keymap.set("n", ",e", killring_pop, { desc = "Killring take from last" })

local function killring_kill()
  killring = setmetatable({}, { __index = table })
  print("ring killed")
end
vim.keymap.set({ "n", "v" }, ",z", killring_kill, { desc = "Killring remove all" })

local function killring_compile()
  local compiled_killring = killring:concat("")
  vim.fn.setreg('"', compiled_killring)
  killring = setmetatable({}, { __index = table })
  print("killring compiled")
end
vim.keymap.set({ "n", "v" }, ",t", killring_compile, { desc = "Killring compile" })

local function killring_compile_reversed()
  local reversed_killring = ReverseTable(killring)
  local compiled_killring = reversed_killring:concat("")
  vim.fn.setreg('"', compiled_killring)
  killring = setmetatable({}, { __index = table })
  print("killring compiled in reverse")
end
function ReverseTable(table)
  local reversed = setmetatable({}, { __index = table })
  local length = #table

  for i = length, 1, -1 do
    table.insert(reversed, table[i])
  end

  return reversed
end

vim.keymap.set({ "n", "v" }, ",T", killring_compile_reversed, { desc = "Killring compile reversed" })

-- For compiling and running code copied from Youtube-video(https://youtu.be/5HXINnalrAQ?si=e3txV-7vtiauIHtW) git(https://arc.net/l/quote/ulxqjqza)

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

-- For lazy loading copied from Nvchad.nvim(https://arc.net/l/quote/rmgllvck)

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
