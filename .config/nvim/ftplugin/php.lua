vim.opt.sts=4
vim.opt.ts=4
vim.opt.sw=4

vim.opt.colorcolumn='120'

vim.opt.iskeyword:remove('$')

vim.g.vdebug_options = {
    port = 9003,
    path_maps = {
        ['/application'] = '/workspace/comote/np/source/newspaper_promotions'
    }
}

local mapper = function(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
end

mapper('n', '<F5>', ':PhpactorImportClass<CR>')
mapper('n', '<F6>', ':PhpactorClassExpand<CR>')
mapper('i', '<F6>', '<ESC> :PhpactorClassExpand<CR>')
mapper('n', '<space>ga', ':call phpactor#GenerateAccessors()<CR>')
mapper('n', '<space>t', ':call phpactor#Transform()<CR>')
mapper('n', '<space>i', ':call phpactor#ImportMissingClasses()<CR>')

vim.api.nvim_exec([[
    highlight ColorColumn ctermbg=236 guibg=#242930 ctermfg=236 guifg=#d70000
]], false)
