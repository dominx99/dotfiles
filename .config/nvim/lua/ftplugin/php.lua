local wrap = require 'keymaps'.wrap

local map = function(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap = true})
end
