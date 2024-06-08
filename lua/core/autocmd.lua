--Auto commands

-- Strip trailing spaces before write
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  desc = "Strip trailing spaces before saving",
  group = vim.api.nvim_create_augroup("strip_space", { clear = true }),
  pattern = { "*" },
  callback = function()
    vim.cmd([[ %s/\s\+$//e ]])
  end,
})

-- Terminal
vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter" }, {
  desc = "Make Termainal took good",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.spell = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.laststatus = 0
    vim.api.nvim_command("startinsert") --to start terminal in insert mood
  end,
})
vim.api.nvim_create_autocmd({ "TermLeave" }, {
  desc = "Make Termainal took good",
  callback = function()
    vim.opt_local.laststatus = 2
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  desc = "Resize windows when terminal is resized",
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- don't auto comment new line
vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Disables auto commenting next line",
  pattern = "*",
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

-- go to last loc when opening a buffer
-- this mean that when you open a file, you will be at the last position
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Go to Last loc when Opening a buffer",
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
  desc = "Hilight when Yanking",
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- user event that loads after UIEnter + only if file buf is there
vim.api.nvim_create_autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_buf_get_option(args.buf, "buftype")

    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      vim.api.nvim_del_augroup_by_name("NvFilePost")

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})

        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end, 0)
    end
  end,
})

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  callback = function()
    vim.defer_fn(function()
      if vim.v.hlsearch == 1 then
        vim.fn.searchcount({ recompute = 1, maxcount = 0 })
        vim.cmd("redrawstatus")
      end
    end, 0)
  end,
})

-- show cursor line only in active window
local cursorGrp = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  pattern = "*",
  callback = function()
    vim.opt.cursorline = true
  end,
  group = cursorGrp,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  pattern = "*",
  callback = function()
    vim.opt.cursorline = false
  end,
  group = cursorGrp,
})
