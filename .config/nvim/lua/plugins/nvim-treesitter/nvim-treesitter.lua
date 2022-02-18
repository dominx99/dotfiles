require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = { "c", "python", "rust", "twig", "html", "css", "js", "html.twig.js.css" },
  },
}
