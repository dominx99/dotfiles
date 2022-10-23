require'nvim-treesitter.configs'.setup {
  ensure_installed = { "php", "typescript", "lua" },
  auto_install = true,

  highlight = {
    enable = true,
    disable = { "c", "python", "rust", "twig", "html", "css", "js", "html.twig.js.css" },
  },
}
