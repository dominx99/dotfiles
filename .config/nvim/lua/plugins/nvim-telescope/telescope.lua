require('telescope').setup{
    defaults = {
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '-uuu',
          '--no-ignore',
          '--glob="!tags"',
        },
        -- border = {},
        -- borderchars = { '', '', '', '', '', '', '', ''},
        layout_config = {
            width = 0.95,
            height = 0.95,
        }
    },
    extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    }
  }
}

vim.api.nvim_exec([[
    nnoremap <M-p> <cmd>lua require('telescope.builtin').find_files()<cr>
    nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
    nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
    nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
    nnoremap <leader>fs <cmd>lua require('telescope.builtin').grep_string()<cr>
    nnoremap <leader>fr <cmd>lua require('telescope.builtin').lsp_references()<cr>
    nnoremap <leader>fds <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>

    highlight TelescopeSelection      guifg=#969600 gui=bold " selected item
    highlight TelescopeSelectionCaret guifg=#CC241D " selection caret
    highlight TelescopeMultiSelection guifg=#928374 " multisections
    highlight TelescopeNormal         guibg=#000000  " floating windows created by telescope.

    " Border highlight groups.
    highlight TelescopeBorder         guifg=#ffffff
    highlight TelescopePromptBorder   guifg=#ffffff
    highlight TelescopeResultsBorder  guifg=#ffffff
    highlight TelescopePreviewBorder  guifg=#ffffff

    " Used for highlighting characters that you match.
    highlight TelescopeMatching       guifg=#007696

    " Used for the prompt prefix
    highlight TelescopePromptPrefix   guifg=red
]], false)

require("telescope").load_extension("ui-select")
