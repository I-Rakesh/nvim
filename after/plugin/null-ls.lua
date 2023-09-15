local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.diagnostics.shellcheck,
    },
})
