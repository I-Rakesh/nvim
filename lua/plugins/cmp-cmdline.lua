return {
  "hrsh7th/cmp-cmdline",
  keys = {
    { "/", desc = "Search Forward" },
    { ":", desc = "Cmdline" },
    { "?", desc = "Search Backward" },
  },
  config = function()
    local cmp = require("cmp")
    -- `/` cmdline setup.
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
    -- `:` cmdline setup.
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man" },
          },
        },
      }),
    })
  end,
}
