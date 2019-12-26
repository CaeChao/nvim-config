" Basic settings
syntax on
set wrapmargin=8
set number
set shell=/bin/zsh
filetype plugin indent on
set nocompatible
set ignorecase
set smartcase
set encoding=utf-8 
set spell spelllang=en_us,cjk
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set scrolloff=3
set showmode
set showcmd
set showmatch
set incsearch
set hlsearch
set autochdir
set undofile          
set wildmenu
set laststatus=2
set modelines=0
set wrap
set linebreak
set formatoptions=qrn1

" security issue
set nomodeline 

" Basics
inoremap jk <ESC> 
let mapleader = "'"

" Run commands with semicolon
nnoremap ; :

" Folding
set nofoldenable

" Aesthetics
colorscheme dracula

" Leader shortcuts
nnoremap <leader>f 1z= 
nnoremap <leader>s :set spell!<CR> 
nnoremap <leader>d :read !date<CR>
nnoremap <leader>tt :TagbarToggle<CR>
nnoremap <leader>gq :%!pandoc -f html -t markdown<CR>
vnoremap <leader>gq :!pandoc -f markdown -t html<CR>

" Miscellaneous 
vnoremap . :norm.<CR>

" Navigation shortcuts
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" fzf find
set rtp+=~/.fzf
nnoremap <leader>l :Files<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>a :Ag

" Movement
nnoremap j gj
nnoremap k gk

" Clipboard functionality (paste from system)
vnoremap  <leader>y "+y
nnoremap  <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" ALE FORMATTERS
autocmd FileType javascript setlocal formatprg=prettier\ --stdin
let g:ale_linters = {
      \ 'javascript': ['prettier', 'eslint'],
      \}
let g:ale_fixers = {'javascript': ['eslint']}
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

" vinegar
let g:ranger_replace_netrw = 1

" Vim Wiki
let g:vimwiki_global_ext=0
autocmd FileType vimwiki set syntax=markdown
let g:vimwiki_list = [{
                      \ 'path': '~/Documents/MyArchive/MyNoteBook',
                      \ 'template_default': 'default',
                      \ 'syntax': 'markdown', 'ext': '.md', 'auto_tags': 1}]
nnoremap <leader>c :Calendar<CR>
nnoremap <leader>st :VimwikiSearchTags

" Plugin Management
set packpath^=~/.vim
packadd minpac

call minpac#init({'package_name': 'myplugins'})

" minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
call minpac#add('k-takata/minpac', {'type': 'opt'})

call minpac#add('junegunn/fzf.vim')
call minpac#add('junegunn/goyo.vim')
call minpac#add('itchyny/lightline.vim')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-abolish')
call minpac#add('tpope/vim-vinegar')
call minpac#add('tpope/vim-commentary')
call minpac#add('vim-pandoc/vim-pandoc')
call minpac#add('vim-pandoc/vim-pandoc-syntax')
call minpac#add('vimwiki/vimwiki')
call minpac#add('mileszs/ack.vim')
call minpac#add('mattn/calendar-vim')
call minpac#add('dense-analysis/ale')
call minpac#add('pangloss/vim-javascript')
call minpac#add('majutsushi/tagbar')

command! Pu call minpac#update()
command! Pc call minpac#clean()
