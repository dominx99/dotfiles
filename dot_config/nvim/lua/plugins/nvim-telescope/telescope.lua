require('telescope').setup{
  defaults = {
    layout_config = {
      width = 0.95,
      height = 0.95,
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '-u',
      '-g',
      '!/var',
      '-g',
      '!/node_modules',
      '-g',
      '!web/build',
      '-g',
      '!node_modules'
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    }
  }
}

require("telescope").load_extension("ui-select")
require("telescope").load_extension("dap")
