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
    }
    local filetype = {
      "filetype",
      icon_only = true,
      colored = true,
      separator = { left = "", right = "" },
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
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "auto",
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },

        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { filetype, "filename" },
        lualine_x = {
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = { fg = "808080" },
          },
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
        },
        lualine_y = { lsp, "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { filetype, "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    })
  end,
}
