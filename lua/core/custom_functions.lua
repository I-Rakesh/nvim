local M = {}

-- Function to toggle relative line numbers
function M.toggle_numbering()
  local cmds = { "rnu!", "nornu!" }
  local current_index = 1
  current_index = current_index % #cmds + 1
  vim.cmd("set " .. cmds[current_index])
  local signcolumn_setting = "auto"
  vim.opt.signcolumn = signcolumn_setting
end

-- Function to toggle Colorcolumn
function M.colorcolumn()
  if vim.o.colorcolumn == "" then
    vim.cmd("let &colorcolumn = '80'")
    vim.notify("Color Column Enabled")
  else
    vim.cmd("let &colorcolumn = ''")
    vim.notify("Color Column Disabled")
  end
end

-- Function to go next and prev in quickfix list
function M.quickfixlist_prev()
  local ok, err = pcall(vim.cmd.cprev)
  if not ok then
    vim.notify(err, vim.log.levels.ERROR)
  end
end

function M.quickfixlist_next()
  local ok, err = pcall(vim.cmd.cnext)
  if not ok then
    vim.notify(err, vim.log.levels.ERROR)
  end
end

-- Change content of Default register to selected registers Youtube-video(https://youtu.be/cz01rOOaLmA?si=7uNqwz0te4UU8zRs) gitbub()https://github.com/Axlefublr/dotfiles/blob/c2a3cabd4aa11a66da714f2c8c620e5b24e86e44/neovim/big.lua
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

function M.move_default_to_other()
  local char = GetChar("Register: ")
  if not char then
    return
  end
  local default_contents = vim.fn.getreg('"')
  vim.fn.setreg(char, default_contents)
end

-- Numbered Registers
local numbered = setmetatable({ "", "", "", "", "", "", "", "", "", "" }, { __index = table })
function M.numbered_get(index)
  if numbered[index] == "" then
    vim.notify(index .. " is empty")
    return
  end
  vim.fn.setreg('"', numbered[index])
  vim.notify("grabbed from " .. index)
end

function M.numbered_set(index)
  local register_contents = vim.fn.getreg('"')
  if register_contents == "" then
    vim.notify("default register empty")
    return
  end
  numbered[index] = register_contents
  vim.notify("stabbed to " .. index)
end

--Function to toggle quickfix window
function M.togglequickfix()
  vim.g.quickfix_opened = 0
  local wininfo = vim.fn.getwininfo()
  if vim.tbl_isempty(vim.fn.filter(wininfo, "v:val.quickfix")) then
    vim.cmd(":copen")
    vim.g.quickfix_opened = 1
  else
    vim.cmd(":cclose")
    vim.g.quickfix_opened = 0
  end
end

-- For compiling and running code  ( Youtube-video(https://youtu.be/5HXINnalrAQ?si=e3txV-7vtiauIHtW) git(https://arc.net/l/quote/ulxqjqza))
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
  php = "open http://localhost:8000 && cd %:p:h && php -S localhost:8000",
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

function M.build()
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
end

function M.debugbuild()
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
end

function M.run()
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
    vim.notify("File type '" .. filetype .. "' is not configured to run.", vim.log.levels.ERROR)
  end
end

function M.compilerun()
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
end

--Killring copied from Youtube-video(https://youtu.be/KCx4mwhXffk?si=g2FJVAhWoJm5RJdk) github(https://github.com/Axlefublr/dotfiles/blob/03f0037c0734bdafaa57ee123d42556f817be84b/neovim/registers/killring.lua)
-- due to the remaps for this feature we can't use local marks(r,e,t,z,g) and global marks(R,T,Z,E)
local killring = setmetatable({}, { __index = table })
function M.killring_push_tail()
  local register_contents = vim.fn.getreg('"')
  if register_contents == "" then
    vim.notify("default register is empty")
    return
  end
  killring:insert(1, register_contents)
  vim.notify("pushed")
end

function M.killring_push()
  local register_contents = vim.fn.getreg('"')
  if register_contents == "" then
    vim.notify("default register is empty")
    return
  end
  killring:insert(register_contents)
  vim.notify("pushed")
end

function M.killring_pop_tail()
  if #killring <= 0 then
    vim.notify("killring empty")
    return
  end
  local first_index = killring:remove(1)
  vim.fn.setreg('"', first_index)
  vim.notify("got tail")
end

function M.killring_pop()
  if #killring <= 0 then
    vim.notify("killring empty")
    return
  end
  local first_index = killring:remove(#killring)
  vim.fn.setreg('"', first_index)
  vim.notify("got nose")
end

function M.killring_kill()
  killring = setmetatable({}, { __index = table })
  vim.notify("ring killed")
end

function M.killring_compile()
  local compiled_killring = killring:concat("")
  vim.fn.setreg('"', compiled_killring)
  killring = setmetatable({}, { __index = table })
  vim.notify("killring compiled")
end

function M.killring_compile_reversed()
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

return M
