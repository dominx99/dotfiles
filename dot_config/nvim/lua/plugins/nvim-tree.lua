require'nvim-tree'.setup {
  view = {
    width = 50,
    side = 'right',
  }
}

vim.api.nvim_exec([[
  let g:nvim_tree_quit_on_open = 1
]], false)
