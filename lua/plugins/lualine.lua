return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    local function getLspName()
      local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
      local clients = vim.lsp.get_active_clients()

      -- Check if the current file is a Java file
      if buf_ft == "java" then
        -- Check if jdtls is among the active clients
        for _, client in ipairs(clients) do
          if client.name == "jdtls" then
            return "  jdtls"
          end
        end
      else
        -- Iterate through other clients
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return "  " .. client.name
          end
        end
      end

      -- If no specific client found, return the default message
      return ""
    end

    local function count()
      local result = vim.fn.searchcount({ recompute = 1 })

      if vim.tbl_isempty(result) then
        return getLspName()
      end

      if result.incomplete == 1 then -- timed out
        return string.format(" /%s [?/??]", vim.fn.getreg("/"))
      elseif result.incomplete == 2 then -- max count exceeded
        if result.total > result.maxcount and result.current > result.maxcount then
          return string.format(" /%s [>%d/>%d]", vim.fn.getreg("/"), result.current, result.total)
        elseif result.total > result.maxcount then
          return string.format(" /%s [%d/>%d]", vim.fn.getreg("/"), result.current, result.total)
        end
      end
      if result.total ~= 0 then
        if vim.v.hlsearch == 1 then
          return string.format(" %s [%d/%d]", vim.fn.getreg("/"), result.current, result.total)
        end
      end
      return getLspName()
    end

    local lsp = {
      function()
        return count()
      end,
      color = { fg = "#6E738D" },
    }

    local filetype = {
      "filetype",
      icon_only = true,
      colored = true,
      separator = { left = "", right = "" },
      padding = { left = 1.5 },
    }

    local copilot_indicator = {
      function()
        local client = vim.lsp.get_active_clients({ name = "copilot" })[1]
        if client == nil then
          return ""
        else
          return ""
        end
      end,
    }

    local macro = {
      function()
        local reg = vim.fn.reg_recording()
        if reg == "" then
          return ""
        end -- not recording
        return "recording @" .. reg
      end,
    }

    local oil_path = {
      function()
        local ok, oil = pcall(require, "oil")
        if ok then
          local current_dir = oil.get_current_dir()
          if current_dir:sub(-1) == "/" and #current_dir > 1 then
            current_dir = current_dir:sub(1, -2)
          end
          return " 󰝰 " .. vim.fn.fnamemodify(current_dir, ":~") .. " %m"
        else
          return ""
        end
      end,
      color = { fg = "#6E738D" },
      padding = { left = 0 },
    }
    local oil = {
      sections = {
        lualine_b = { "mode" },
        lualine_c = { --[[ "mode", ]]
          oil_path,
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          -- {
          --   require("noice").api.statusline.mode.get,
          --   cond = require("noice").api.statusline.mode.has,
          --   color = { fg = "#ff9e64" },
          -- },
          macro,
          copilot_indicator,
          "location",
          "progress",
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { oil_path },
        lualine_x = {
          "location",
          "progress",
        },
        lualine_y = {},
        lualine_z = {},
      },
      filetypes = { "oil" },
    }

    local function fugitive_branch()
      local icon = ""
      return icon .. " " .. vim.fn.FugitiveHead()
    end
    local fugitive = {
      sections = {
        lualine_c = { fugitive_branch },
        lualine_x = { "location", "progress" },
      },
      filetypes = { "fugitive" },
    }

    local function is_loclist()
      return vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0
    end
    local function label()
      return is_loclist() and "Location List" or "Quickfix List"
    end
    local function title()
      if is_loclist() then
        return vim.fn.getloclist(0, { title = 0 }).title
      end
      return vim.fn.getqflist({ title = 0 }).title
    end
    local quickfix = {
      sections = {
        lualine_b = { label },
        lualine_c = { title },
        lualine_x = { "progress" },
      },
      filetypes = { "qf" },
    }

    local nvim_dap_ui = {
      sections = {
        lualine_b = { { "filename", file_status = false } },
      },
      filetypes = {
        "dap-repl",
        "dapui_console",
        "dapui_watches",
        "dapui_stacks",
        "dapui_breakpoints",
        "dapui_scopes",
      },
    }

    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = " ", right = "" },

        disabled_filetypes = {
          statusline = { "DiffviewFiles" },
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 10,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = { "mode" },
        lualine_c = {
          -- "mode",
          filetype,
          { "filename", path = 1, padding = { right = 1 } },
          "diagnostics",
          { "branch", color = { fg = "#6E738D" }, icon = "", padding = { left = 1.5 } },
          {
            "diff",
            symbols = {
              added = " ",
              modified = " ",
              removed = " ",
            },
            diff_color = {
              added = { fg = "#5E7B54" },
              modified = { fg = "#7C6E53" },
              removed = { fg = "#A75F69" },
            },
          },
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          macro,
          lsp,
          copilot_indicator,
          "location",
          "progress",
        },
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { filetype, { "filename", path = 1, padding = { right = 0 } } },
        lualine_x = {
          "location",
          "progress",
        },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        lualine_b = { { "tabs", mode = 2 } },
      },
      winbar = {},
      inactive_winbar = {},
      extensions = { fugitive, quickfix, nvim_dap_ui, oil },
    })
    vim.opt.showtabline = 1
  end,
}
