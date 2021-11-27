set sts=4
set ts=4
set sw=4

nnoremap <F6> :call phpactor#ClassExpand()<CR>

set colorcolumn=120
highlight ColorColumn ctermbg=236 guibg=#242930 ctermfg=236 guifg=#d70000

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

setlocal iskeyword-=$

nnoremap <space>t :call phpactor#Transform()<CR>
