nnoremap c "_c

map <F7> :setlocal spell! spelllang=en_us<CR>
map <F8> :setlocal spell! spelllang=pl<CR>
map ; :
map j gj
map k gk
imap jj <Esc>
inoremap <M-w> <Esc>:bd<CR>
nnoremap <M-w> :bd<CR>
inoremap <M-s> <Esc>:w<CR>
nnoremap <M-s> :w<CR>
map <silent> <expr> <M-p> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
map <M-o> :GFiles<CR>
nmap <silent> <Space><Space> :noh<CR>
map <M-e> :Buffers<CR>

inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" resize
map <silent> <M-=> :vertical resize +5<CR>
map <silent> <M--> :vertical resize -5<CR>

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
vnoremap <C-c> "+y
map <C-p> "+P

" Align arrays
vnoremap <leader>a :Tabularize /=<CR>
vnoremap <space>a :Tabularize /=><CR>

" Replace \"\" or ''
nnoremap q' viw<Esc>`>a'<Esc>`<i'<Esc>
vnoremap q' <Esc>`>a'<Esc>`<i'<Esc>
nnoremap q" viw<Esc>`>a"<Esc>`<i"<Esc>
vnoremap q" <Esc>`>a"<Esc>`<i"<Esc>
nnoremap qd vaW<esc>:call StripWrap()<cr>
vnoremap qd <esc>:call StripWrap()<cr>

function! StripWrap()
  normal `>x`<x
endfunction

nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP
