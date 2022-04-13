require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = { "c", "python", "rust", "twig", "html", "css", "js", "html.twig.js.css" },
  },
}
