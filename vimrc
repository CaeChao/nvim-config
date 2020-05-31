" Basic settings
syntax on
set wrapmargin=8
set number
set shell=/bin/zsh
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
set wrap
set linebreak
set formatoptions=qrn1

" security issue
set nomodeline 

" Remap
inoremap jk <ESC> 
let mapleader = "'"

" Run commands with semicolon
nnoremap ; :

" Folding
set nofoldenable

" Aesthetics
colorscheme dracula

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Leader shortcuts
nnoremap <leader>f 1z= 
nnoremap <leader>s :set spell!<CR> 
nnoremap <leader>d :read !date<CR>
nnoremap <leader>tt :TagbarToggle<CR>
nnoremap <leader>gq :%!pandoc -f html -t markdown<CR>
vnoremap <leader>gq :!pandoc -f markdown -t html<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>:wincmd p<CR>
nnoremap <leader>mp :InstantMarkdownPreview<CR>
nnoremap <leader>ms :InstantMarkdownStop<CR>

" Miscellaneous 
vnoremap . :norm.<CR>

" Navigation shortcuts
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Movement
nnoremap j gj
nnoremap k gk

" Clipboard functionality (paste from system)
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>d "+d
vnoremap <leader>d "+d

" NERDTree
let NERDTreeMinimalUI=1 " Disable bookmark and 'press ? for help' text
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" fzf find
set rtp+=~/.fzf
nnoremap <leader>l :Files<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>a :Ag

" Markdown-preview
let g:instant_markdown_autostart = 0

" Use deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#depths = 1
inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" gutentags
let g:gutentags_add_default_project_roots = 0
let g:gutentags_generate_on_write = 1
let g:gutentags_project_root = ['.root', '.svn', '.git', 'package.json']
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')

" ALE FORMATTERS
autocmd FileType javascript setlocal formatprg=prettier\ --stdin
let g:ale_linters = {
      \ 'javascript': ['prettier', 'eslint'],
      \}
let g:ale_fixers = {
      \ 'javascript': ['prettier'],
      \ 'css': ['prettier'],
      \}
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
                      \ 'path': '~/Dropbox/Apps/vimwiki',
                      \ 'template_default': 'default',
                      \ 'syntax': 'markdown', 'ext': '.md', 'auto_tags': 1}]
au FileType vimwiki set syntax=markdown.pandoc
nnoremap <leader>c :Calendar<CR>

"{{ Plugin Management
call plug#begin('~/.vim/pack/myplugins/start')
" Buffer/File/Tag Browsing
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-vinegar'
if executable('ctags')
    " plugin to manage your tags
    Plug 'ludovicchabant/vim-gutentags'
    " show file tags in vim window
    Plug 'majutsushi/tagbar', { 'on': ['TagbarToggle', 'TagbarOpen'] }
endif
" Status Bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Coding/Writing
Plug 'junegunn/goyo.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" Git Integration
Plug 'tpope/vim-fugitive', {'on': ['Gstatus']}
Plug 'Xuyuanp/nerdtree-git-plugin'
" Others
Plug 'vimwiki/vimwiki'
Plug 'mattn/calendar-vim'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
call plug#end()
"}}
