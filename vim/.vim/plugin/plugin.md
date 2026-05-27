# 项目代码总览

## 1. Directory Tree

- .auto-pairs.vim.swp
- auto-pairs.vim
- coc-nvim.vim
- copilot.vim.bak
- indentline.vim.bak
- ultisnips.vim
- vim-airline.vim
- vim-cmdline-fzf.vim
- vim-markdown.vim
- vim-quickui.vim.bak

---

## 2. File Contents

### .auto-pairs.vim.swp

*skipped*

### auto-pairs.vim

```vim
let g:AutoPairsShortcutJump = '<m-tab>'
au FileType markdown let b:AutoPairs = AutoPairsDefine({'<!--' : '-->','$':'$','_':'_','*':'*','__':'__','**':'**'})

```

### coc-nvim.vim

```vim
" Confirm completion with <C-CR> if the popup menu is visible.
" Otherwise, break the undo chain and trigger coc#on_enter() (typically for formatting).
inoremap <silent><expr> <C-CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Navigate the completion list using <C-j> (next item) and <C-k> (previous item).
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"

```

### copilot.vim.bak

```bak
autocmd VimEnter * Copilot disable

```

### indentline.vim.bak

```bak
let g:indentLine_setConceal = 0 "keep my own conceal setting, otherwise indentline plugin will override
set conceallevel=2
" set concealcursor=nc

```

### ultisnips.vim

```vim
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

```

### vim-airline.vim

```vim
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = "base16_adwaita"
set noshowmode "disable mode-showing from vim itself

```

### vim-cmdline-fzf.vim

```vim
" ── FZF command-line completion ───────────────────────────────────────────────
let s:saved_cmd = ''
let s:prefix    = ''

" Find the end of cmd which match to the completion, return the prefix which don't need replacement
function! s:GetPrefix(cmd, completions)
  let first = a:completions[0]
  for i in range(0, len(a:cmd))
    let suffix = a:cmd[i :]
    if stridx(first, suffix) == 0
      return i == 0 ? '' : a:cmd[: i - 1]
    endif
  endfor
  return a:cmd
endfunction

function! s:FzfCmdlineTab()
  if getcmdtype() !=# ':'
    return "\<C-t>"
  endif

  let cmd = getcmdline()
  let completions = getcompletion(cmd, 'cmdline')

  if empty(completions)
    return "\<C-t>"
  endif

  let s:saved_cmd = cmd
  let s:prefix    = s:GetPrefix(cmd, completions)

  call timer_start(1, {-> s:RunFzf(completions)})
  return "\<C-c>"
endfunction

function! s:RunFzf(items)
  call fzf#run(fzf#wrap({
    \ 'source':  a:items,
    \ 'sink*':   function('s:Sink'),
    \ 'options': [
    \   '--prompt=>> ',
    \   '--bind=ctrl-j:down,ctrl-k:up',
    \   '--expect=esc',
    \   '--no-multi',
    \ ],
    \ 'down': '30%',
    \ }))
endfunction

function! s:Sink(lines)
  if get(a:lines, 0, '') ==# 'esc' || len(a:lines) < 2
    call feedkeys(':' . s:saved_cmd, 'nt')
    return
  endif
  call feedkeys(':' . s:prefix . a:lines[1], 'nt')
endfunction

cnoremap <expr> <Tab> <SID>FzfCmdlineTab()
" ─────────────────────────────────────────────────────────────────────────────

```

### vim-markdown.vim

```vim
let g:markdown_fenced_languages = ['Python=python']
let g:vim_markdown_borderless_table = 1

```

### vim-quickui.vim.bak

```bak
" clear all the menus
call quickui#menu#reset()

" install a 'File' menu, use [text, command] to represent an item.
call quickui#menu#install('&File', [
            \ [ "&New File\tCtrl+n", 'echo 0' ],
            \ [ "&Open File\t(F3)", 'echo 1' ],
            \ [ "&Close", 'echo 2' ],
            \ [ "--", '' ],
            \ [ "&Save\tCtrl+s", 'echo 3'],
            \ [ "Save &As", 'echo 4' ],
            \ [ "Save All", 'echo 5' ],
            \ [ "--", '' ],
            \ [ "E&xit\tAlt+x", 'echo 6' ],
            \ ])

" items containing tips, tips will display in the cmdline
call quickui#menu#install('&Edit', [
            \ [ '&Copy', 'echo 1', 'help 1' ],
            \ [ '&Paste', 'echo 2', 'help 2' ],
            \ [ '&Find', 'echo 3', 'help 3' ],
            \ ])

" script inside %{...} will be evaluated and expanded in the string
call quickui#menu#install("&Option", [
			\ ['Set &Spell %{&spell? "Off":"On"}', 'set spell!'],
			\ ['Set &Cursor Line %{&cursorline? "Off":"On"}', 'set cursorline!'],
			\ ['Set &Paste %{&paste? "Off":"On"}', 'set paste!'],
			\ ])

" register HELP menu with weight 10000
call quickui#menu#install('H&elp', [
			\ ["&Cheatsheet", 'help index', ''],
			\ ['T&ips', 'help tips', ''],
			\ ['--',''],
			\ ["&Tutorial", 'help tutor', ''],
			\ ['&Quick Reference', 'help quickref', ''],
			\ ['&Summary', 'help summary', ''],
			\ ], 10000)

" enable to display tips in the cmdline
let g:quickui_show_tip = 1

" hit space twice to open menu
noremap <leader><leader> :call quickui#menu#open()<cr>

```

