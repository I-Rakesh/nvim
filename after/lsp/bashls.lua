return {
  settings = {
    bashIde = {
      -- Disable shellcheck in bash-language-server. It conflicts with linter settings. And it is slow compared conform.nvim
      shellcheckPath = "",
    },
  },
}
