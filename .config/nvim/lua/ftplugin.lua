vim.cmd([[
  augroup init
    autocmd FileType lua lua require('ftplugin.lua')
    autocmd FileType php lua require('ftplugin.php')
  augroup END
]])
