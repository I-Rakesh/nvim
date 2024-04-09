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

    local lsp = {
      function()
        return getLspName()
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
    local oil_path = {
      function()
        local current_directory = vim.fn.expand("%:p:h")
        local replacements = {
          ["^oil:///Users/rakesh/?"] = "~/",
          ["^oil:///Users?$"] = "/Users",
          ["^oil:?$"] = "/",
        }
        local filtered_directory = current_directory
        for pattern, replacement in pairs(replacements) do
          filtered_directory = string.gsub(filtered_directory, pattern, replacement)
        end

        local modified = vim.api.nvim_buf_get_option(0, "modified")
        if not modified then
          return " 󰝰 " .. filtered_directory
        else
          return " 󰝰 " .. filtered_directory .. " [+]"
        end
      end,
      color = { fg = "#6E738D" },
      padding = { left = 0 },
    }
    local copilot_indicator = {
      function()
        local client = vim.lsp.get_active_clients({ name = "copilot" })[1]
        if client == nil then
          return ""
        else
          return ""
        end
      end,
    }
    local oil = {
      sections = {
        lualine_c = { "mode", oil_path },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = "#ff9e64" },
          },
          copilot_indicator,
          { "location", padding = { left = 0 } },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { oil_path },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      filetypes = { "oil" },
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
        lualine_b = {},
        lualine_c = {
          "mode",
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
          -- stylua: ignore
          -- {
          --   function() return require("noice").api.status.command.get() end,
          --   cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          --   color = { fg = "808080" },
          -- },
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = "#ff9e64" },
          },
          lsp,
          copilot_indicator,
          "progress",
          { "location", padding = { left = 0 } },
        },
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { filetype, { "filename", path = 1, padding = { right = 0 } } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        lualine_b = { { "tabs", mode = 2 } },
      },
      winbar = {},
      inactive_winbar = {},
      extensions = { "fugitive", "quickfix", "trouble", "nvim-dap-ui", oil },
    })
    vim.opt.showtabline = 1
  end,
}
