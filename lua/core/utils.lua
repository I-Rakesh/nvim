--Change Default register to selected registers Youtube-video(https://youtu.be/cz01rOOaLmA?si=7uNqwz0te4UU8zRs) gitbub()https://github.com/Axlefublr/dotfiles/blob/c2a3cabd4aa11a66da714f2c8c620e5b24e86e44/neovim/big.lua

function GetChar(prompt)
  vim.api.nvim_echo({ { prompt, "Input" } }, true, {})
  local char = vim.fn.getcharstr()
  -- That's the escape character (<Esc>). Not sure how to specify it smarter
  -- In other words, if you pressed escape, we return nil
  if char == "" then
    return nil
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

vim.keymap.set("n", "'g", Move_default_to_other)

--Numbered Registers

local numbered = setmetatable({ "", "", "", "", "", "", "", "", "", "" }, { __index = table })

local function numbered_get(index)
  if numbered[index] == "" then
    vim.notify(index .. " is empty")
    return
  end
  vim.fn.setreg('"', numbered[index])
  vim.notify("grabbed")
end

local function numbered_set(index)
  local register_contents = vim.fn.getreg('"')
  if register_contents == "" then
    vim.notify("default register empty")
    return
  end
  numbered[index] = register_contents
  vim.notify("stabbed")
end

vim.keymap.set({ "n" }, '"1', function()
  numbered_get(1)
end, { desc = "Past From Temporary Register 1" })
vim.keymap.set({ "n" }, '"2', function()
  numbered_get(2)
end, { desc = "Past From Temporary Register 2" })
vim.keymap.set({ "n" }, '"3', function()
  numbered_get(3)
end, { desc = "Past From Temporary Register 3" })
vim.keymap.set({ "n" }, '"4', function()
  numbered_get(4)
end, { desc = "Past From Temporary Register 4" })
vim.keymap.set({ "n" }, '"5', function()
  numbered_get(5)
end, { desc = "Past From Temporary Register 5" })
vim.keymap.set({ "n" }, '"6', function()
  numbered_get(6)
end, { desc = "Past From Temporary Register 6" })
vim.keymap.set({ "n" }, '"7', function()
  numbered_get(7)
end, { desc = "Past From Temporary Register 7" })
vim.keymap.set({ "n" }, '"8', function()
  numbered_get(8)
end, { desc = "Past From Temporary Register 8" })
vim.keymap.set({ "n" }, '"9', function()
  numbered_get(9)
end, { desc = "Past From Temporary Register 9" })
vim.keymap.set({ "n" }, '"0', function()
  numbered_get(10)
end, { desc = "Past From Temporary Register 0" })

vim.keymap.set({ "n" }, "'1", function()
  numbered_set(1)
end, { desc = "Save To Temporary Register 1" })
vim.keymap.set({ "n" }, "'2", function()
  numbered_set(2)
end, { desc = "Save To Temporary Register 2" })
vim.keymap.set({ "n" }, "'3", function()
  numbered_set(3)
end, { desc = "Save To Temporary Register 3" })
vim.keymap.set({ "n" }, "'4", function()
  numbered_set(4)
end, { desc = "Save To Temporary Register 4" })
vim.keymap.set({ "n" }, "'5", function()
  numbered_set(5)
end, { desc = "Save To Temporary Register 5" })
vim.keymap.set({ "n" }, "'6", function()
  numbered_set(6)
end, { desc = "Save To Temporary Register 6" })
vim.keymap.set({ "n" }, "'7", function()
  numbered_set(7)
end, { desc = "Save To Temporary Register 7" })
vim.keymap.set({ "n" }, "'8", function()
  numbered_set(8)
end, { desc = "Save To Temporary Register 8" })
vim.keymap.set({ "n" }, "'9", function()
  numbered_set(9)
end, { desc = "Save To Temporary Register 9" })
vim.keymap.set({ "n" }, "'0", function()
  numbered_set(10)
end, { desc = "Save To Temporary Register 10" })

--Killring copied from Youtube-video(https://youtu.be/KCx4mwhXffk?si=g2FJVAhWoJm5RJdk) github(https://github.com/Axlefublr/dotfiles/blob/03f0037c0734bdafaa57ee123d42556f817be84b/neovim/registers/killring.lua)

-- due to the remaps for this feature we can use local marks(r,e,t,z,g) and global marks(R,T,Z,E)

local killring = setmetatable({}, { __index = table })

local function killring_push_tail()
  local register_contents = vim.fn.getreg('"')
  if register_contents == "" then
    vim.notify("default register is empty")
    return
  end
  killring:insert(1, register_contents)
  vim.notify("pushed")
end
vim.keymap.set("n", "'R", killring_push_tail, { desc = "Killring Add at first" })

local function killring_push()
  local register_contents = vim.fn.getreg('"')
  if register_contents == "" then
    vim.notify("default register is empty")
    return
  end
  killring:insert(register_contents)
  vim.notify("pushed")
end
vim.keymap.set("n", "'r", killring_push, { desc = "Killring Add at last" })

local function killring_pop_tail()
  if #killring <= 0 then
    vim.notify("killring empty")
    return
  end
  local first_index = killring:remove(1)
  vim.fn.setreg('"', first_index)
  vim.notify("got tail")
end
vim.keymap.set("n", "'E", killring_pop_tail, { desc = "Killring take from top" })

local function killring_pop()
  if #killring <= 0 then
    vim.notify("killring empty")
    return
  end
  local first_index = killring:remove(#killring)
  vim.fn.setreg('"', first_index)
  vim.notify("got nose")
end
vim.keymap.set("n", "'e", killring_pop, { desc = "Killring take from last" })

local function killring_kill()
  killring = setmetatable({}, { __index = table })
  vim.notify("ring killed")
end
vim.keymap.set({ "n", "v" }, "'z", killring_kill, { desc = "Killring remove all" })

local function killring_compile()
  local compiled_killring = killring:concat("")
  vim.fn.setreg('"', compiled_killring)
  killring = setmetatable({}, { __index = table })
  vim.notify("killring compiled")
end
vim.keymap.set({ "n", "v" }, "'t", killring_compile, { desc = "Killring compile" })

local function killring_compile_reversed()
  local reversed_killring = ReverseTable(killring)
  local compiled_killring = reversed_killring:concat("")
  vim.fn.setreg('"', compiled_killring)
  killring = setmetatable({}, { __index = table })
  vim.notify("killring compiled in reverse")
end
function ReverseTable(table)
  local reversed = setmetatable({}, { __index = table })
  local length = #table

  for i = length, 1, -1 do
    table.insert(reversed, table[i])
  end

  return reversed
end

vim.keymap.set({ "n", "v" }, "'T", killring_compile_reversed, { desc = "Killring compile reversed" })

if not vim.g.vscode then
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

  -- For compiling and running code copied from Youtube-video(https://youtu.be/5HXINnalrAQ?si=e3txV-7vtiauIHtW) git(https://arc.net/l/quote/ulxqjqza)

  local build_commands = {
    c = "!gcc -std=c11 -o %:p:r.o %",
    cpp = "!g++ -std=c++17 -Wall -O2 -o %:p:r.o %",
    rust = "!cargo build --release",
    go = "!go build",
    tex = "VimtexCompile",
    java = "!javac %",
    sh = "!chmod +x %",
    typescript = "!tsc %",
  }

  local debug_build_commands = {
    c = "!gcc -std=c11 -g -o %:p:r.o %",
    cpp = "!g++ -std=c++17 -g -o %:p:r.o %",
    rust = "!cargo build",
    go = "!go build",
  }

  local run = {
    c = "gcc -std=c11 -o %:p:r.o % && %:p:r.o",
    cpp = "g++ -std=c++17 -Wall -O2 -o %:p:r.o % && %:p:r.o",
    rust = "cargo build --release && cargo run --release",
    go = "go build && go run .",
    tex = "VimtexCompile",
    javascript = "node %",
    typescript = "tsc % && node %:p:r.js",
    java = "javac % && java %",
    python = "python3 %",
    html = "open %",
    sh = "chmod +x % && ([[ -f ./% ]] && ./% || %)",
  }

  local run_commands = {
    c = "%:p:r.o",
    cpp = "%:p:r.o",
    rust = "cargo run --release",
    go = "go run .",
    tex = "",
    javascript = "node %",
    typescript = "node %:p:r.js",
    java = "java %",
    python = "python3 %",
    html = "open %",
    sh = "([[ -f ./% ]] && ./% || %)",
  }

  vim.api.nvim_create_user_command("Build", function()
    local filetype = vim.bo.filetype
    local supported = false

    for file, command in pairs(build_commands) do
      if filetype == file then
        vim.cmd("silent :w")
        vim.notify("Building file")
        vim.cmd("silent " .. command)
        supported = true
        break
      end
    end
    if not supported then
      vim.notify("File type '" .. filetype .. "' is not configured to Build.", vim.log.levels.ERROR)
    end
  end, {})

  vim.api.nvim_create_user_command("DebugBuild", function()
    local filetype = vim.bo.filetype
    local supported = false

    for file, command in pairs(debug_build_commands) do
      if filetype == file then
        vim.cmd("silent :w")
        vim.notify("DebugBuild file")
        vim.cmd("silent " .. command)
        supported = true
        break
      end
    end
    if not supported then
      vim.notify("File type '" .. filetype .. "' is not configured to DebugBuild.", vim.log.levels.ERROR)
    end
  end, {})

  -- Testing to debug build when setting up breakpoints
  --[[ vim.api.nvim_create_user_command("DapBuild", function()
  local filetype = vim.bo.filetype
  for file, command in pairs(debug_build_commands) do
    if filetype == file then
      vim.cmd("silent :w")
      vim.cmd("silent " .. command)
      break
    end
  end
end, {}) ]]

  vim.api.nvim_create_user_command("Run", function()
    local filetype = vim.bo.filetype
    local supported = false

    for file, command in pairs(run_commands) do
      if filetype == file then
        vim.cmd("sp")
        vim.cmd("term " .. command)
        vim.cmd("resize 15")
        local keys = vim.api.nvim_replace_termcodes("", true, false, true)
        vim.api.nvim_feedkeys(keys, "n", false)
        supported = true
        break
      end
    end
    if not supported then
      vim.notify("File type '" .. filetype .. "' is not configured to run.", "error")
    end
  end, {})

  vim.api.nvim_create_user_command("CompileRun", function()
    local filetype = vim.bo.filetype
    local supported = false

    for file, command in pairs(run) do
      if filetype == file then
        vim.cmd("silent :w")
        if filetype == "html" then
          vim.cmd("silent !" .. command)
        else
          vim.cmd("sp")
          vim.cmd("term " .. command)
          local win_height = vim.api.nvim_win_get_height(0)
          local term_height = math.floor(win_height / 1.7)
          vim.cmd("resize " .. term_height)
          local keys = vim.api.nvim_replace_termcodes("", true, false, true)
          vim.api.nvim_feedkeys(keys, "n", false)
        end
        supported = true
        break
      end
    end
    if not supported then
      vim.notify("File type '" .. filetype .. "' is not configured to run.", vim.log.levels.ERROR)
    end
  end, {})

  --Keymaps
  vim.keymap.set("n", "<leader>rr", "<cmd>CompileRun<CR>", { desc = "Run Current file" })
  vim.keymap.set("n", "<leader>rb", "<cmd>Build<CR>", { desc = "Build Current file" })
  vim.keymap.set("n", "<leader>rd", "<cmd>DebugBuild<CR>", { desc = "DebugBuild Current file" })
end
