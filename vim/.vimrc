"basic config
set nocompatible
set clipboard=unnamed
set encoding=utf-8
set number
set relativenumber

" Sane backspace behavior
set backspace=indent,eol,start

set autoindent " Basic indentation logic
set smartindent " Smart auto-indenting for new lines
set showmatch " Highlight matching brackets/parentheses
set incsearch " Highlight search results as typed
set hlsearch " Highlight all search terms

" Command line completion improvements
"set wildmenu " Show command line options in a list
"set wildmode=list:longest,full " Improved command completion behavior
set wildoptions=pum

"Plugins
call plug#begin('~/.vim/plugged')
Plug 'SirVer/ultisnips' "for snippeting (currently latex only)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy find
Plug 'junegunn/fzf.vim'
Plug 'vifm/vifm.vim' "vifm support for file management
Plug 'jiangmiao/auto-pairs' "autp pairing
Plug 'github/copilot.vim' "AI support
Plug 'tpope/vim-commentary' "comment codes
Plug 'wellle/targets.vim' "add more text objects
Plug 'tpope/vim-surround' "text-surrounding support
Plug 'vim-airline/vim-airline' "for status line
Plug 'vim-airline/vim-airline-themes' "for airline themes
Plug 'preservim/vim-markdown', { 'for': 'markdown' } "richer markdown support
"Plug 'skywind3000/vim-quickui' "for quick gui assisstance
" Plug 'dense-analysis/ale' "for syntax checking (not sure how to use, archived currently)
" Plug 'neoclide/coc.nvim', {'branch': 'release'} "custom popup menu with snippet support
" for Markdown
" for LaTeX
Plug 'lervag/vimtex', { 'for': 'tex' }" for latex support
Plug 'KeitaNakamura/tex-conceal.vim', { 'for': 'tex' } "for tex concealing (currently not using)
call plug#end()

set cursorline
" Change background color to a dark gray in terminals
highlight CursorLine ctermbg=darkgray
" Change current line number color to red
highlight CursorLineNr ctermbg=darkgray ctermfg=blue

syntax enable
filetype on             " enable filetype detection
filetype plugin indent on      " load file-specific plugins & indentation

" leader key setting
let mapleader=" "
" map <space> alone to no operation instead of moving forward
nnoremap <space> <nop>
" <leader>+fzf for fzf
nnoremap <leader>fzf :Files<CR>
" <leader>+fm for vifm
nnoremap <leader>fm :Vifm ./<CR>
" <leader>+bf for vifm
nnoremap <leader>bf :Buffers<CR>
" <leader>+cd to cd to current buffer
nnoremap <Leader>cd :cd %:h <Bar> pwd<CR>

" " Enable spell only for markdown via autocommand (move from global)
" augroup my_spell
"   autocmd!
"   autocmd FileType markdown setlocal spell spelllang=en_us
" augroup END
" " Map: keep it simple
" inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u


" ---------------------------
" Tips: measure after changes:
" Run in shell:
"   vim --startuptime /dev/stdout +qall && echo && time vim +q
" then inspect top lines to see which files occupy most time.
" ---------------------------
