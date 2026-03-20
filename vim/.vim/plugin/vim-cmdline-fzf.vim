" ── FZF command-line file completion ──────────────────────────────────────────
let s:fzf_cl_saved_cmd = ''
let s:fzf_cl_prefix = ''

function! s:FzfCmdlineTab()
  if getcmdtype() !=# ':'
    return "\<Tab>"
  endif

  let cmd = getcmdline()
  if cmd !~ '\s'
    return "\<Tab>"
  endif

  let cmd_word = substitute(matchstr(cmd, '^\s*\zs\S\+'), '[!|].*', '', '')
  let file_cmds = ['e','edit','vs','vsp','vsplit','sp','split',
    \ 'new','vnew','tabe','tabedit','r','read',
    \ 'w','write','sav','saveas','lcd','cd','source']

  if index(file_cmds, cmd_word) < 0
    return "\<Tab>"
  endif

  let s:fzf_cl_saved_cmd = cmd

  let partial = matchstr(cmd, '\S*$')
  let before  = cmd[: len(cmd) - len(partial) - 1]
  let base_dir = '.'
  let query = partial

  if partial =~# '/'
    let dir_part = matchstr(partial, '^.*/')
    let query    = matchstr(partial, '[^/]*$')
    let before   = before . dir_part
    let base_dir = dir_part
  endif

  let s:fzf_cl_prefix = before
  let expanded_dir = expand(base_dir)

  call timer_start(1, {-> s:FzfCmdlineRun(query, expanded_dir)})
  return "\<C-c>"
endfunction

function! s:FzfCmdlineRun(query, dir)
  let dir = empty(a:dir) ? '.' : a:dir
  call fzf#run(fzf#wrap({
    \ 'source':  'ls -1Ap ' . shellescape(dir),
    \ 'sink*':   function('s:FzfCmdlineSink'),
    \ 'options': [
    \   '--query=' . a:query,
    \   '--prompt=>> ',
    \   '--bind=ctrl-j:down,ctrl-k:up',
    \   '--expect=esc',
    \   '--no-multi',
    \ ],
    \ 'down': '30%',
    \ }))
endfunction

function! s:FzfCmdlineSink(lines)
  if get(a:lines, 0, '') ==# 'esc' || len(a:lines) < 2
    call feedkeys(':' . s:fzf_cl_saved_cmd, 'nt')
    return
  endif
  call feedkeys(':' . s:fzf_cl_prefix . a:lines[1], 'nt')
endfunction

cnoremap <expr> <Tab> <SID>FzfCmdlineTab()
" ──────────────────────────────────────────────────────────────────────────────
