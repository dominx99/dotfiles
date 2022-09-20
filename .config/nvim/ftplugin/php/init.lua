vim.opt.sts=4
vim.opt.ts=4
vim.opt.sw=4

vim.opt.colorcolumn='120'
vim.opt.iskeyword:remove('$')

local mapper = function(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
end

mapper('n', '<leader>i', ':PhpactorImportClass<CR>')
mapper('n', '<leader>e', 'bi\\<ESC> :PhpactorClassExpand<CR>')
mapper('i', '<leader>e', '<ESC>bi\\<ESC> :PhpactorClassExpand<CR>')
mapper('n', '<space>ga', ':call phpactor#GenerateAccessors()<CR>')
mapper('n', '<space>t', ':call phpactor#Transform()<CR>')
mapper('n', '<space>i', ':call phpactor#ImportMissingClasses()<CR>')
mapper('n', '<space>mf', ':call phpactor#MoveFile()<CR>')

vim.api.nvim_exec([[
  highlight ColorColumn ctermbg=236 guibg=#242930 ctermfg=236 guifg=#d70000
]], false)
