set sts=2
set ts=2
set sw=2

setlocal iskeyword+=$

let g:ale_disable_lsp = 1
let b:ale_fixers = ['prettier', 'eslint']
" let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma all'
