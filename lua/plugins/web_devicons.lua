return {
  "kyazdani42/nvim-web-devicons",
  lazy = true,
  opts = {
    override_by_extension = {
      ["go"] = {
        icon = "",
        color = "#00ADD8",
        name = "go",
      },
      ["java"] = {
        icon = "󰬷",
        color = "#DB8AA2",
        name = "java",
      },
    },
  },
}
