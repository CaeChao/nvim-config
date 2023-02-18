" Basic settings
syntax on
set wrapmargin=8
set number                              " Line numbers
set shell=/bin/zsh
set ignorecase
set smartcase
set encoding=utf-8 
set spelllang=en_us,cjk

" Buffer settings
set sessionoptions+=globals
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set formatoptions=qrn1
set autoindent                          " Good auto indent
set smarttab

set scrolloff=3
set noshowmode
set showcmd
set showmatch
set incsearch
set hlsearch
set autochdir
set undofile          
set wildmenu
set laststatus=2
set hidden
set wrap
set linebreak
set mouse=a
set nocompatible
set showtabline=0
set t_Co=256                            " Support 256 colors
set nomodeline                          " security issue
if has('termguicolors')
  set termguicolors
endif
set nofoldenable                        " Folding
let g:highlightedyank_highlight_duration = 1000
