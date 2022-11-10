local null_ls = require("null-ls")

null_ls.setup({
  debug = true,
  sources = {
    null_ls.builtins.diagnostics.curlylint,
    null_ls.builtins.diagnostics.twigcs,
    null_ls.builtins.formatting.prettierd,
  },
})
