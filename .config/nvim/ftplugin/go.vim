augroup go
    autocmd!
    au BufRead,BufNewFile *.tmpl set filetype=gotplhtml
    autocmd BufWritePre <buffer> call CocAction('runCommand', 'editor.action.organizeImport')
augroup END


