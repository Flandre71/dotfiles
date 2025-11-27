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
" for Markdown
Plug 'preservim/vim-markdown', { 'for': 'markdown' } "richer markdown support
" for LaTeX
Plug 'lervag/vimtex', { 'for': 'tex' }" for latex support
Plug 'KeitaNakamura/tex-conceal.vim', { 'for': 'tex' } "for tex concealing (currently not using)
call plug#end()

syntax enable
filetype on             " enable filetype detection
filetype plugin indent on      " load file-specific plugins & indentation

" leader key setting
let mapleader=" "
" map <space> alone to no operation instead of moving forward
nnoremap <space> <nop>
" <leader>+e for fzf
nnoremap <leader>F :Files<CR>
" <leader>+f for vifm
nnoremap <leader>V :Vifm ./<CR>
" <leader>+cd to cd to current buffer
nnoremap <Leader>cd :cd %:h<CR>

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
