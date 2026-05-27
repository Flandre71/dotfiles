# Overview

## 1. Directory Tree

- python.vim
- **markdown/**
  - markdown.vim
  - vim-markdown.vim
- **tex/**
  - tex-conceal.vim
  - vimtex.vim

---

## 2. File Contents

### python.vim

```vim
"Set 4 spaces for tabs and indentation
au FileType python setlocal shiftwidth=4 tabstop=4 expandtab softtabstop=4

"<leader>+r to save and run current file
noremap <buffer> <leader>r :w<CR>:exec '!python3' shellescape(@%, 1)<CR>

```

### markdown/markdown.vim

```vim
set conceallevel=2
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_borderless_table = 1
let g:vim_markdown_toc_autofit = 1

```

### markdown/vim-markdown.vim

```vim
let g:markdown_fenced_languages = ['Python=python']
let g:vim_markdown_borderless_table = 1

```

### tex/tex-conceal.vim

```vim
set conceallevel=2
let g:tex_conceal='abdmg'
hi Conceal ctermbg=none

```

### tex/vimtex.vim

```vim
"let mapleader=" "
let g:tex_flavor='latex'
let g:vimtex_view_method='skim'
let g:vimtex_quickfix_mode=0
nmap <leader>c :VimtexCompile<CR>
nnoremap <leader>w :w<CR>
nmap <leader>v <plug>(vimtex-view)

augroup LatexAutoSave
    autocmd!
" set auto-update time from default(4000ms) to 500ms
    set updatetime=500
" save after cursor holds longer than updatetime or loose focus
    autocmd CursorHold,FocusLost,InsertLeave *.tex silent! update
augroup END
" set indent to 4 spaces
setlocal expandtab
setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4

```

