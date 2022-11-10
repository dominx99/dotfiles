local mapper = function(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
end

mapper('n', '<space>q', ':Trouble<CR>')
