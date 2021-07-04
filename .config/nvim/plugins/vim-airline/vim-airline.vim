let g:airline_theme='deus'

function! AirlineInit()
    let g:airline_section_z = airline#section#create(['%{ObsessionStatus(''$'', '''')}', 'windowswap', '%3p%% ', 'linenr', ':%3v '])
endfunction
autocmd User AirlineAfterInit call AirlineInit()
" let g:airline_section_a = airline#section#create(['mode'])
" let g:airline_section_b = airline#section#create(['filename'])
" let g:airline_section_c = airline#section#create(['bufferline', 'branch'])
