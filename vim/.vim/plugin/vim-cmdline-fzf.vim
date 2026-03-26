" FZF command-line completion 
let s:saved_cmd = ''
let s:prefix    = ''

function! s:FzfCmdlineTab()
  if getcmdtype() !=# ':'
    return "\<C-t>"
  endif

  let cmd = getcmdline()
  let completions = getcompletion(cmd, 'cmdline')

  " back to original completion if no options
  if empty(completions)
    return "\<C-t>"
  endif

  let s:saved_cmd = cmd

  " no space: complete the command itself with empty perfix
  " with space: perfix reached to the last space, displace with the last part
  if cmd !~# '\s'
    let s:prefix = ''
  else
    let s:prefix = cmd[: strridx(cmd, ' ')]
  endif

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
