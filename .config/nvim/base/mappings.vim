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
inoremap <M-q> <Esc>:wq<CR>
nnoremap <M-q> :wq<CR>
map <silent> <expr> <M-P> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
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

nnoremap <silent> <M-+> :resize +3<CR>
nnoremap <silent> <M-_> :resize -3<CR>

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
vnoremap <C-c> "+y
map <C-p> "+P

" Replace \"\" or ''
nnoremap q' viw<Esc>`>a'<Esc>`<i'<Esc>
vnoremap q' <Esc>`>a'<Esc>`<i'<Esc>
nnoremap q" viw<Esc>`>a"<Esc>`<i"<Esc>
vnoremap q" <Esc>`>a"<Esc>`<i"<Esc>
nnoremap q` viw<Esc>`>a`<Esc>`<i`<Esc>
vnoremap q` <Esc>`>a`<Esc>`<i`<Esc>
nnoremap qd vaW<esc>:call StripWrap()<cr>
vnoremap qd <esc>:call StripWrap()<cr>

function! StripWrap()
  normal `>x`<x
endfunction

nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP

nnoremap <C-]> <Esc>:JumpToTag <C-r>=expand("<cword>")<CR><CR>
inoremap <C-T> <Esc>:JumpToTag<Space>
nnoremap <C-T> :JumpToTag<Space>

map <M-F> :call SearchInProject()<CR>
map <M-f> :Ag<CR>

nnoremap <M-b> :NvimTreeToggle<CR>

nnoremap <C-f> :FocusOnFile<CR>

nnoremap yf gg^vG$y

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <leader>cw :ClearWhitespaces<CR>
