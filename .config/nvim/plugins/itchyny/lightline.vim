let g:lightline = {
      \ 'colorscheme': 'base16',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste', 'ObsessionStatus' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ],
      \    'right':[
          \     [ 'blame', 'gitbranch', 'filetype', 'fileencoding', 'lineinfo', 'percent' ]
          \   ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'blame': 'LightlineGitBlame'
      \ },
      \ }

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction


