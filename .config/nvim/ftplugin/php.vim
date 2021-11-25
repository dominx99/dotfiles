echomsg "PHP ftplugin loaded!"

" setlocal foldmethod=indent
" setlocal foldlevelstart=1
" setlocal foldlevel=1
set sts=4
set ts=4
set sw=4

" available 'length', 'alpha', 'no'
let g:vim_php_use_sort = 'no'

" Insert use statement
function! IPhpInsertUse()
    call PHPImportClass()
    call feedkeys('a',  'n')
endfunction

" Expand class name
function! IPhpExpandClass()
    normal ewbi\
    normal l
    call PHPExpandFQCNAbsolute()
endfunction
nnoremap <F6> :PHPExpandFQCNAbsolute<CR>
inoremap <F6> <Esc>:call IPhpExpandClass()<CR>

" nnoremap <space>d :call PHPInsertDocblockHandler(getline("."))<CR>
" nnoremap <space>d :call PHPInsertDocblockHandler(getline("."))<CR>
command! PhpUseFix Silent php-cs-fixer fix %:p --rules="no_unused_imports" --using-cache="no"

inoremap <F5> <Esc>:PHPImportClass<CR>i
nnoremap <F5> :PHPImportClass<CR>
nnoremap <leader>s :PHPSetter<CR>
" autocmd FileType php nnoremap <Leader>u :PHPImportClass<cr>
" autocmd FileType php nnoremap <Leader>E :PHPExpandFQCN<cr>
inoremap <F6> <Esc>:PHPExpandFQCNAbsolute<CR>i
nnoremap <F6> :PHPExpandFQCNAbsolute<CR>

command! GTags !tags

" Only do this when not done yet for this buffer
if exists("b:did_phpgetset_ftplugin")
  finish
endif
let b:did_phpgetset_ftplugin = 1

" Make sure we are in vim mode
let s:save_cpo = &cpo
set cpo&vim

" TEMPLATE SECTION:
" The templates can use the following placeholders which will be replaced
" with appropriate values when the template is invoked:
"
"   %varname%       The name of the property
"   %funcname%      The method name ("getXzy" or "setXzy")
"
" The templates consist of a getter and setter template.
"
" Getter Templates
if exists("g:phpgetset_getterTemplate")
  let s:phpgetset_getterTemplate = g:phpgetset_getterTemplate
else
  let s:phpgetset_getterTemplate =
    \ "\n" .
    \ "    /**\n" .
    \ "     * @return %type% %varname%\n" .
    \ "     */\n" .
    \ "    public function %funcname%(): %type%\n" .
    \ "    {\n" .
    \ "        return $this->%varname%;\n" .
    \ "    }"
endif

" Setter Templates
if exists("g:phpgetset_setterTemplate")
  let s:phpgetset_setterTemplate = g:phpgetset_setterTemplate
else
  let s:phpgetset_setterTemplate =
  \ "\n" .
  \ "    /**\n" .
  \ "     * @param %type% %varname%\n" .
  \ "     */\n" .
  \ "    public function %funcname%($%varname%)\n" .
  \ "    {\n" .
  \ "        $this->%varname% = $%varname%;\n" .
  \ "    }"
endif


" Position where methods are inserted.  The possible values are:
"   0 - end of class
"   1 = above block / line
"   2 = below block / line
if exists("b:phpgetset_insertPosition")
  let s:phpgetset_insertPosition = b:phpgetset_insertPosition
else
  let s:phpgetset_insertPosition = 0
endif

" Script local variables that are used like globals.
"
" If set to 1, the user has requested that getters be inserted
let s:getter    = 0

" If set to 1, the user has requested that setters be inserted
let s:setter    = 0

" The current indentation level of the property (i.e. used for the methods)
" let s:indent    = ''

" The name of the property
let s:varname   = ''

" The function name of the property (capitalized varname)
let s:funcname  = ''

" The first line of the block selected
let s:firstline = 0

" The last line of the block selected
let s:lastline  = 0

" Regular expressions used to match property statements
let s:phpname = '[a-zA-Z_$][a-zA-Z0-9_$]*'
let s:brackets = '\(\s*\(\[\s*\]\)\)\='
let s:variable = '\(\s*\)\(\([private,protected,public]\s\+\)*\)\$\(' . s:phpname . '\)\s*\(;\|=[^;]\+;\)'

" The main entry point. This function saves the current position of the
" cursor without the use of a mark (see note below)  Then the selected
" region is processed for properties.
"
" FIXME: I wanted to avoid clobbering any marks in use by the user, so I
" manually try to save the current position and restore it.  The only drag
" is that the position isn't restored correctly if the user opts to insert
" the methods ABOVE the current position.  Using a mark would solve this
" problem as they are automatically adjusted.  Perhaps I just haven't
" found it yet, but I wish that VIM would let a scripter save a mark and
" then restore it later.  Why?  In this case, I'd be able to use a mark
" safely without clobbering any user marks already set.  First, I'd save
" the contents of the mark, then set the mark, do my stuff, jump back to
" the mark, and finally restore the mark to what the user may have had
" previously set.  Seems weird to me that you can't save/restore marks.
"
if !exists("*s:InsertGetterSetter")
  function s:InsertGetterSetter(flag) range
    let restorepos = line(".") . "normal!" . virtcol(".") . "|"
    let s:firstline = a:firstline
    let s:lastline = a:lastline

    if s:DetermineAction(a:flag)
      call s:ProcessRegion(s:GetRangeAsString(a:firstline, a:lastline))
    endif

    execute restorepos

    " Not sure why I need this but if I don't have it, the drawing on the
    " screen is messed up from my insert.  Perhaps I'm doing something
    " wrong, but it seems to me that I probably shouldn't be calling
    " redraw.
    redraw!

  endfunction
endif

" Set the appropriate script variables (s:getter and s:setter) to
" appropriate values based on the flag that was selected.  The current
" valid values for flag are: 'g' for getter, 's' for setter, 'b' for both
" getter/setter, and 'a' for ask/prompt user.
if !exists("*s:DetermineAction")
  function s:DetermineAction(flag)

    if a:flag == 'g'
      let s:getter = 1
      let s:setter = 0

    elseif a:flag == 's'
      let s:getter = 0
      let s:setter = 1

    elseif a:flag == 'b'
      let s:getter = 1
      let s:setter = 1

    elseif a:flag == 'a'
      return s:DetermineAction(s:AskUser())

    else
      return 0
    endif

    return 1
  endfunction
endif

" Ask the user what they want to insert, getter, setter, or both.  Return
" an appropriate flag for use with s:DetermineAction, or return 0 if the
" user cancelled out.
if !exists("*s:AskUser")
  function s:AskUser()
    let choice =
        \   confirm("What do you want to insert?",
        \           "&Getter\n&Setter\n&Both", 3)

    if choice == 0
      return 0

    elseif choice == 1
      return 'g'

    elseif choice == 2
      return 's'

    elseif choice == 3
      return 'b'

    else
      return 0

    endif
  endfunction
endif

" Gets a range specified by a first and last line and returns it as a
" single string that will eventually be parsed using regular expresssions.
" For example, if the following lines were selected:
"
"     // Age
"     var $age;
"
"     // Name
"     var $name;
"
" Then, the following string would be returned:
"
"     // Age    var $age;    // Name    var $name;
"
if !exists("*s:GetRangeAsString")
  function s:GetRangeAsString(first, last)
    let line = a:first
    let string = s:TrimRight(getline(line))

    while line < a:last
      let line = line + 1
      let string = string . s:TrimRight(getline(line))
    endwhile

    return string
  endfunction
endif

" Trim whitespace from right of string.
if !exists("*s:TrimRight")
  function s:TrimRight(text)
    return substitute(a:text, '\(\.\{-}\)\s*$', '\1', '')
  endfunction
endif

" Process the specified region indicated by the user.  The region is
" simply a concatenated string of the lines that were selected by the
" user.  This string is searched for properties (that match the s:variable
" regexp).  Each property is then processed.  For example, if the region
" was:
"
"     // Age    var $age;    // Name    var $name;
"
" Then, the following strings would be processed one at a time:
"
" var $age;
" var $name;
"
if !exists("*s:ProcessRegion")
  function s:ProcessRegion(region)
    let startPosition = match(a:region, s:variable, 0)
    let endPosition = matchend(a:region, s:variable, 0)

    while startPosition != -1
      let result = strpart(a:region, startPosition, endPosition - startPosition)

      "call s:DebugParsing(result)
      call s:ProcessVariable(result)

      let startPosition = match(a:region, s:variable, endPosition)
      let endPosition = matchend(a:region, s:variable, endPosition)
    endwhile

  endfunction
endif

" Process a single property.  The first thing this function does is
" break apart the property into the following components: indentation, name
" In addition, the following other components are then derived
" from the previous: funcname. For example, if the specified variable was:
"
" var $name;
"
" Then the following would be set for the global variables:
"
" indent    = '    '
" varname   = 'name'
" funcname  = 'Name'
"
if !exists("*s:ProcessVariable")
  function s:ProcessVariable(variable)
    let s:indent    = substitute(a:variable, s:variable, '\1', '')
    let s:varname   = substitute(a:variable, s:variable, '\4', '')
    echo string(s:varname)

    if exists("*PhpGetsetProcessFuncname")
        let s:funcname = PhpGetsetProcessFuncname(s:varname)
    else
        let s:funcname  = toupper(s:varname[0]) . strpart(s:varname, 1)
    endif

    " If any getter or setter already exists, then just return as there
    " is nothing to be done.  The assumption is that the user already
    " made his choice.
    if s:AlreadyExists()
      return
    endif

    if s:getter
      call s:InsertGetter()
    endif

    if s:setter
      call s:InsertSetter()
    endif

  endfunction
endif

" Checks to see if any getter/setter exists.
if !exists("*s:AlreadyExists")
  function s:AlreadyExists()
    return search('\(get\|set\)' . s:funcname . '\_s*([^)]*)\_s*{', 'w')
  endfunction
endif

" Inserts a getter by selecting the appropriate template to use and then
" populating the template parameters with actual values.
if !exists("*s:InsertGetter")
  function s:InsertGetter()

    let method = s:phpgetset_getterTemplate


    let method = substitute(method, '%varname%', s:varname, 'g')
    let method = substitute(method, '%funcname%', 'get' . s:funcname, 'g')

    call s:InsertMethodBody(method)

  endfunction
endif

" Inserts a setter by selecting the appropriate template to use and then
" populating the template parameters with actual values.
if !exists("*s:InsertSetter")
  function s:InsertSetter()

    let method = s:phpgetset_setterTemplate

    let method = substitute(method, '%varname%', s:varname, 'g')
    let method = substitute(method, '%funcname%', 'set' . s:funcname, 'g')

    call s:InsertMethodBody(method)

  endfunction
endif

" Inserts a body of text using the indentation level.  The passed string
" may have embedded newlines so we need to search for each "line" and then
" call append separately.  I couldn't figure out how to get a string with
" newlines to be added in one single call to append (it kept inserting the
" newlines as ^@ characters which is not what I wanted).
if !exists("*s:InsertMethodBody")
  function s:InsertMethodBody(text)
    call s:MoveToInsertPosition()

    let pos = line('.')
    let string = a:text

    while 1
      let len = stridx(string, "\n")

      if len == -1
        call append(pos, s:indent . string)
        break
      endif

      call append(pos, s:indent . strpart(string, 0, len))

      let pos = pos + 1
      let string = strpart(string, len + 1)

    endwhile
  endfunction
endif

" Move the cursor to the insertion point.  This insertion point can be
" defined by the user by setting the b:phpgetset_insertPosition variable.
if !exists("*s:MoveToInsertPosition")
  function s:MoveToInsertPosition()

    " 1 indicates above the current block / line
    if s:phpgetset_insertPosition == 1
      execute "normal! " . (s:firstline - 1) . "G0"

    " 2 indicates below the current block / line
    elseif s:phpgetset_insertPosition == 2
      execute "normal! " . s:lastline . "G0"

    " 0 indicates end of class (and is default)
    else
      execute "normal! ?{\<CR>w99[{%k" | nohls

    endif

  endfunction
endif

" Debug code to decode the properties.
if !exists("*s:DebugParsing")
  function s:DebugParsing(variable)
    echo 'DEBUG: ===================================================='
    echo 'DEBUG:' a:variable
    echo 'DEBUG: ----------------------------------------------------'
    echo 'DEBUG:    indent:' substitute(a:variable, s:variable, '\1', '')
    echo 'DEBUG:      name:' substitute(a:variable, s:variable, '\4', '')
    echo ''
  endfunction
endif

" Add mappings, unless the user didn't want this.  I'm still not clear why
" I need to have two (2) noremap statements for each, but that is what the
" example shows in the documentation so I've stuck with that convention.
" Ideally, I'd prefer to use only one noremap line and map the <Plug>
" directly to the ':call <SID>function()<CR>'.
if !exists("no_plugin_maps") && !exists("no_php_maps")
  if !hasmapto('<Plug>PhpgetsetInsertGetterSetter')
    map <unique> <buffer> <LocalLeader>p <Plug>PhpgetsetInsertGetterSetter
  endif
  noremap <buffer> <script>
    \ <Plug>PhpgetsetInsertGetterSetter
    \ <SID>InsertGetterSetter
  noremap <buffer>
    \ <SID>InsertGetterSetter
    \ :call <SID>InsertGetterSetter('a')<CR>

  if !hasmapto('<Plug>PhpgetsetInsertGetterOnly')
    map <unique> <buffer> <LocalLeader>g <Plug>PhpgetsetInsertGetterOnly
  endif
  noremap <buffer> <script>
    \ <Plug>PhpgetsetInsertGetterOnly
    \ <SID>InsertGetterOnly
  noremap <buffer>
    \ <SID>InsertGetterOnly
    \ :call <SID>InsertGetterSetter('g')<CR>

  if !hasmapto('<Plug>PhpgetsetInsertSetterOnly')
    map <unique> <buffer> <LocalLeader>s <Plug>PhpgetsetInsertSetterOnly
  endif
  noremap <buffer> <script>
    \ <Plug>PhpgetsetInsertSetterOnly
    \ <SID>InsertSetterOnly
  noremap <buffer>
    \ <SID>InsertSetterOnly
    \ :call <SID>InsertGetterSetter('s')<CR>

  if !hasmapto('<Plug>PhpgetsetInsertBothGetterSetter')
    map <unique> <buffer> <LocalLeader>b <Plug>PhpgetsetInsertBothGetterSetter
  endif
  noremap <buffer> <script>
    \ <Plug>PhpgetsetInsertBothGetterSetter
    \ <SID>InsertBothGetterSetter
  noremap <buffer>
    \ <SID>InsertBothGetterSetter
    \ :call <SID>InsertGetterSetter('b')<CR>
endif

" Add commands, unless already set.
if !exists(":InsertGetterSetter")
  command -range -buffer
    \ InsertGetterSetter
    \ :<line1>,<line2>call s:InsertGetterSetter('a')
endif
if !exists(":InsertGetterOnly")
  command -range -buffer
    \ InsertGetterOnly
    \ :<line1>,<line2>call s:InsertGetterSetter('g')
endif
if !exists(":InsertSetterOnly")
  command -range -buffer
    \ InsertSetterOnly
    \ :<line1>,<line2>call s:InsertGetterSetter('s')
endif
if !exists(":InsertBothGetterSetter")
  command -range -buffer
    \ InsertBothGetterSetter
    \ :<line1>,<line2>call s:InsertGetterSetter('b')
endif

let &cpo = s:save_cpo

"if !exists("*s:InsertText")
"  function s:InsertText(text)
"    let pos = line('.')
"    let beg = 0
"    let len = stridx(a:text, "\n")
"
"    while beg < strlen(a:text)
"      if len == -1
"        call append(pos, s:indent . strpart(a:text, beg))
"        break
"      endif
"
"      call append(pos, s:indent . strpart(a:text, beg, len))
"      let pos = pos + 1
"      let beg = beg + len + 1
"      let len = stridx(strpart(a:text, beg), "\n")
"    endwhile
"
"    " Not too sure why I have to call redraw, but weirdo things appear
"    " on the screen if I don't.
"    redraw!
"
"  endfunction
"endif
"
"if !exists("*s:InsertAccessor")
"  function s:InsertAccessor()
"    echo "InsertAccessor was called"
"  endfunction
"endif
"
"if !exists("*s:SqueezeWhitespace")
"  function s:SqueezeWhitespace(string)
"      return substitute(a:string, '\_s\+', ' ', 'g')
"  endfunction
"endif

" List of tags found
let s:tags = []

" Determine if the options window is open
let s:windowIsOpen = 0

" Action to do when a class is selected by the user, it can be:
" use                  : Insert the use statement
" expand_fqcn          : Expand the FQCN
" expand_fqcn_absolute : Expand the FQCN with a leading backslash
let s:action = 'use'

" Tag kinds, to use on s:GetTagKind(...)
let s:kinds = {'c': 'Class', 't': 'Trait', 'i': 'Interface'}

let s:previous_win_nr = 0

" Default value for use sort variable, values could be:
" length = Sort by length
" alpha  = Sort alphabetically
" Any other value means no sort.
let g:vim_php_use_sort = get(g:, 'vim_php_use_sort', 'length')

" Define commands for PHP user
command! PHPImportClass call s:PHPImportClass('use')
command! PHPExpandFQCN call s:PHPImportClass('expand_fqcn')
command! PHPExpandFQCNAbsolute call s:PHPImportClass('expand_fqcn_absolute')

"
" Start the import process
"
function! s:PHPImportClass(action)
    let s:previous_win_nr = winnr()
    let s:action = a:action
    let l:class = expand('<cword>')
    let s:tags = s:SearchTags(l:class)

    if empty(s:tags)
        call s:Message('Class, trait or interface "'.l:class.'" not found.')
        return
    endif

    if len(s:tags) == 1
        call s:SelectOption(0)
    else
        call s:DisplayOptions()
    endif
endfunction

function! PHPImportClassFor(action, class)
    let s:previous_win_nr = winnr()
    let s:action = a:action
    let l:class = a:class
    let s:tags = s:SearchTags(l:class)

    if empty(s:tags)
        call s:Message('Class, trait or interface "'.l:class.'" not found.')
        return
    endif

    if len(s:tags) == 1
        call s:SelectOption(0)
    else
        call s:DisplayOptions()
    endif
endfunction

"
" Open a window to display a list of FQCN of the found tags to let the user
" select an option or cancel.
"
function! s:DisplayOptions()

    " Make the options list.
    let l:options = s:MakeOptionsList()

    " Open a new window to display the options list.
    execute 'bo '.len(l:options).'new'
    let s:windowIsOpen = 1

    " Write each option in a line an then move cursor to the top.
    call append(0, l:options)
    normal! ddgg0

    " Avoid the user modify the buffer contents.
    setlocal cursorline
    setlocal nomodifiable
    setlocal statusline=Select\ a\ Class,\ trait\ or\ interface

    " Syntax highlighting
    " I'm not sure if this is a good place to write syntax highlight :/
    syn keyword elementType Class Trait Inter
    hi def link elementType Keyword

    " This buffer command will be called when user select an option.
    command! -buffer PHPSelectOption call s:SelectOption(line('.') - 1)

    " Map common keys to select or close the options window.
    nnoremap <buffer> <esc> :q!<cr>:echo "Canceled"<cr>
    nnoremap <buffer> <cr> :PHPSelectOption<cr>
endfunction

"
" Select and option from the found tags and apply the requested action
" (s:action)
"
function! s:SelectOption(index)
    let l:tag = s:tags[a:index]
    let l:kind = s:GetTagKind(l:tag)
    let l:fqcn = l:tag.namespace.'\'.l:tag.name

    " Close the window if it's open
    if s:windowIsOpen
        execute "normal! :q!\<cr>"
        let s:windowIsOpen = 0
    endif

    execute ":".s:previous_win_nr."wincmd w"

    if s:action == 'use'
        if s:FqcnExists(l:fqcn)
            call s:Message(l:kind.' "'.l:fqcn.'" already in use.')
        else
            call s:InsertUseStatement(l:fqcn)
            call s:Message(l:kind.' "'.l:fqcn.'" imported.')
        endif
    elseif s:action == 'expand_fqcn' || s:action == 'expand_fqcn_absolute'
        let l:namespace = l:tag.namespace

        " Prepend the backslash if needed
        if s:action == 'expand_fqcn_absolute'
            let l:namespace = '\'.l:namespace
        endif

        " Insert the namespace before de current word using a register.
        let @x = l:namespace.'\'
        execute "normal! viw\<esc>b\"xPe"

        call s:Message(l:kind.' "'.l:fqcn.'" expanded.')
    endif


 endfunction

"
" Search for classes or traits using the given pattern
"
function! s:SearchTags(class)
    let l:tags = []

    " Search tags and filter by type: class, trait or interface
    for l:tag in taglist('\C^'.a:class.'$')

        " Not all tags have a namespace, those will be considered as root
        " classes.
        if has_key(l:tag, 'namespace') == 0
            let l:tag.namespace = ''
        endif

        if l:tag.kind == 'c' || l:tag.kind == 't' || l:tag.kind == 'i'
            let l:tag.namespace = s:NormalizeNamespace(l:tag)
            call add(l:tags, l:tag)
        endif
    endfor

    return l:tags
endfunction

"
" Takes a List of tags and return a List of options to pass in inputlist()
"
function! s:MakeOptionsList()
    let l:options = []

    for l:tag in s:tags
        " Add tail backslash only if the namespace is not empty.
        let l:namespace = l:tag.namespace == '' ? '' : l:tag.namespace.'\'
        call add(l:options, ' '.strpart(s:GetTagKind(l:tag), 0, 5).' '.l:namespace.l:tag.name)
    endfor

    return l:options
endfunction

"
" Remove the double backslashes from a namespace.
"
function! s:NormalizeNamespace(tag)
    let l:ns = a:tag.namespace

    if stridx(l:ns, '\\') > -1
        let l:ns = substitute(l:ns, '\\\\', '\\', 'g')
    endif

    return l:ns
endfunction

"
" Checks if the given fqcn is already in use.
"
function! s:FqcnExists(fqcn)
    " Escape the backslash, this is needed because we expect a normalized
    " fqcn which it don't have escaped backslashes.
    let l:escaped = substitute(a:fqcn, '\\', '\\\\', 'g')

    " Search for the use statement, for example: use App\\Class;
    return s:SearchInBuffer('^use '.l:escaped.';')
endfunction

"
" Returns true if the given pattern exists in the current buffer
"
function! s:SearchInBuffer(pattern)
    normal! mx
    let l:lineNumber = search(a:pattern)
    normal! `x
    return l:lineNumber > 0
endfunction

"
" Sort the "use" statements.
"
function! s:SortUseStatements(lastLine)
    normal! gg
    let l:firstLine = search('^use .*;$', 'n')

    if l:firstLine == a:lastLine
        return
    endif

    if g:vim_php_use_sort == 'alpha'
        execute l:firstLine . ',' . a:lastLine . 'sort'
    elseif g:vim_php_use_sort == 'length'
        " Prepend the length number to each use statment, then sort the lines by
        " number and the final step is remove the length number.
        execute l:firstLine . ',' . a:lastLine . 's/^use .*;$/\=strdisplaywidth( submatch(0) ).":".submatch(0)/'
        execute l:firstLine . ',' . a:lastLine . 'sort n'
        execute l:firstLine . ',' . a:lastLine . 's/^\d\+://'
    endif
endfunction

"
" Insert the "use" statement with the given namespace
"
function! s:InsertUseStatement(fqcn)

    let l:use = 'use ' . a:fqcn . ';'

    normal! mx

    " Try to insert after the last "use" statement.
    if search('^use .*;$', 'be') > 0
        call append(line('.'), l:use)
        call s:SortUseStatements(line('.') + 1)

    " Try to insert after the "namespace" statement, leaving one blank line
    " before the "use" statement.
    elseif search('^namespace .*;$') > 0
        call append(line('.'), '')
        call append(line('.') + 1, l:use)

    " Try to insert after the "<?php" statement, leaving one blank line
    " before the "use" statement.
    elseif search('^<?php') > 0
        call append(line('.'), '')
        call append(line('.') + 1, l:use)

    " Insert at the top of the file
    else
        call append(1, l:use)
    endif

    normal! `x
endfunction

"
" Display a nice message
"
function! s:Message(message)
    redraw
    echo a:message
endfunction

"
" Returns the tag kind
"
function! s:GetTagKind(tag)
    return s:kinds[a:tag.kind]
endfunction

set colorcolumn=120
highlight ColorColumn ctermbg=236 guibg=#242930 ctermfg=236 guifg=#d70000

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

setlocal iskeyword-=$
