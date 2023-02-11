require('telescope').setup{
  defaults = {
    layout_config = {
      width = 0.95,
      height = 0.95,
    }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    }
  }
}

require("telescope").load_extension("ui-select")
require("telescope").load_extension("dap")
