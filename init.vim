set runtimepath^=~/.vim
set runtimepath+=~/.vim/plugins/ultisnips
let &packpath=&runtimepath

" Basic settings
syntax on
set wrapmargin=8
set number                              " Line numbers
set shell=/bin/zsh
set ignorecase
set smartcase
set encoding=utf-8 
set spell spelllang=en_us,cjk
set softtabstop=2
set tabstop=2
set expandtab
set autoindent                          " Good auto indent
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
set hidden
set wrap
set linebreak
set formatoptions=qrn1
set mouse=a
set nocompatible
set showtabline=0
set t_Co=256                            " Support 256 colors
" set shiftwidth=2
set smarttab
set nomodeline                          " security issue

" Remap
inoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>
nnoremap ; :
let mapleader = "'"
let g:dispatch_no_maps = 1

" Leader shortcuts
nnoremap <leader>f 1z= 
nnoremap <leader>s :set spell!<CR> 
nnoremap <leader>D :read !date<CR>
nnoremap <leader>tt :TagbarToggle<CR>
nnoremap <leader>gq :%!pandoc -f html -t markdown<CR>
vnoremap <leader>gq :!pandoc -f markdown -t html<CR>
nnoremap <leader>n :NERDTreeToggle<CR>:wincmd p<CR>
nnoremap <leader>N :NERDTreeCWD<CR>
nnoremap <leader>q :b#<bar>bd#<CR>

" Miscellaneous 
vnoremap . :norm.<CR>

" Movement/Navigation shortcuts
nnoremap j gj
nnoremap k gk
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <silent> <C-n> :bnext<CR>
nnoremap <silent> <C-p> :bprevious<CR>

" Clipboard functionality (paste from system)
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>d "+d
vnoremap <leader>d "+d
let g:highlightedyank_highlight_duration = 1000

" Folding
set nofoldenable

" CtrlSpace
let g:CtrlSpaceDefaultMappingKey = "<C-space> "

" Aesthetics
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark = 'medium'
" set background=dark
" colorscheme gruvbox8

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_detect_spell=0
let g:airline_detect_spelllang=0

" NERDTree
let NERDTreeMinimalUI=1 " Disable bookmark and 'press ? for help' text
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vinegar
let g:ranger_replace_netrw = 1
let g:NERDTreeHijackNetrw = 0
let g:ranger_map_keys = 0

" fzf find
set rtp+=~/.fzf
let g:fzf_preview_window = ['right:50%', 'ctrl-_']
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, $AG_DEFAULT_OPTIONS, fzf#vim#with_preview(), <bang>0)
" nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>a :Ag

"" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Markdown-preview
nmap <leader>mp <Plug>MarkdownPreview
nmap <leader>ms <Plug>MarkdownPreviewStop
let g:mkdp_command_for_global = 0
let g:mkdp_filetypes = ['markdown', 'pandoc', 'vimwiki']

"{{ AutoCompete

"# deoplete config
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#sources#ternjs#types = 1
" let g:deoplete#sources#ternjs#depths = 1

"# Coc config
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

function! s:coc_confirm() abort
  if pumvisible()
    return coc#_select_confirm()
  else
    return "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  endif
endfunction
" <CR> to handle completion
inoremap <silent> <CR> <C-r>=<SID>coc_confirm()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-actions',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-cssmodules',
  \ 'coc-stylelintplus',
  \ 'coc-svg',
  \ 'coc-prettier',
  \ 'coc-eslint',
  \ 'coc-tsserver',
  \ 'coc-emoji',
  \ 'coc-vimlsp',
  \ 'coc-xml',
  \ 'coc-yank',
  \ 'coc-json',
  \ 'coc-python',
  \ 'coc-java'
  \ ]
command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 Eslint :CocCommand eslint.executeAutofix
nnoremap <silent> F :call CocAction('format')<CR>

" navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation Remap.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Remap keys for applying codeAction to the current buffer.
nmap <leader>do <Plug>(coc-codeaction)


"# ALE FORMATTERS
autocmd FileType javascript setlocal formatprg=prettier\ --stdin
let g:ale_linters = {
      \ 'javascript': ['prettier', 'eslint'],
      \ 'typescript': ['tsserver'],
      \}
let g:ale_fixers = {
      \ 'javascript': ['prettier', 'eslint'],
      \ 'typescript': ['prettier', 'eslint'],
      \ 'css': ['prettier'],
      \}
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0
let g:ale_fix_on_save = 0
"}}

" GV
function! s:gv_expand()
   let line = getline('.')
   GV --name-status
   call search('\V'.line, 'c')
   normal! zz
endfunction
autocmd! FileType GV nnoremap <buffer> <silent> + :call <sid>gv_expand()<cr>

" Snippets trigger configuration 
let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger='<TAB>'
let g:UltiSnipsJumpBackwardTrigger='<S-TAB>'

" JSDOC
nmap <leader>jd ?function<cr>:noh<cr><Plug>(jsdoc)

" gutentags
let g:gutentags_add_default_project_roots = 0
let g:gutentags_generate_on_write = 1
let g:gutentags_project_root = ['.root', '.svn', '.git', 'package.json']
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')

" Coding Syntax
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
au BufNewFile,BufRead /*.rasi setf css

" VimWiki
autocmd FileType vimwiki set syntax=markdown.pandoc
let g:vimwiki_global_ext = 0
let g:vimwiki_table_mappings=0
nnoremap <leader>gl :VimwikiGenerateLinks
nmap <leader>x <Plug>VimwikiToggleListItem
let g:vimwiki_list = [{
                      \ 'path': '~/MyArchive/vimwiki',
                      \ 'template_default': 'default',
                      \ 'syntax': 'markdown', 'ext': '.md', 'auto_tags': 1}]
let g:tagbar_type_vimwiki = {
          \   'ctagstype':'vimwiki'
          \ , 'kinds':['h:header']
          \ , 'sro':'&&&'
          \ , 'kind2scope':{'h':'header'}
          \ , 'sort':0
          \ , 'ctagsbin':'~/.vim/plugins/taskwiki/extra/vwtags.py'
          \ , 'ctagsargs': 'markdown'
          \ }
nnoremap <leader>c :Calendar<CR>
let g:taskwiki_source_tw_colors="yes"
let g:taskwiki_maplocalleader="'tw"

" ============================================================================
" VIM-PLUG PLUGINS {{{
" ============================================================================

call plug#begin('~/.vim/plugins')
" Buffer/File/Tag Browsing
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-vinegar'
if executable('ctags')
    " plugin to manage your tags
    Plug 'ludovicchabant/vim-gutentags'
    " show file tags in vim window
    Plug 'majutsushi/tagbar', { 'on': ['TagbarToggle', 'TagbarOpen'] }
endif
" Status/Tabline Bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ctrlspace/vim-ctrlspace'
" Coding
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'dense-analysis/ale'
" Edit
Plug 'junegunn/goyo.vim'
Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'vim-pandoc/vim-pandoc'
" Syntax
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'sheerun/vim-polyglot'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'elzr/vim-json'
Plug 'heavenshell/vim-jsdoc', { 
  \ 'for': ['javascript', 'javascript.jsx','typescript'], 
  \ 'do': 'make install'
\}
" Git Integration
Plug 'tpope/vim-fugitive', {'on': ['Gstatus']}
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/gv.vim'
" Others
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-gruvbox8'
Plug 'machakann/vim-highlightedyank'
Plug 'vimwiki/vimwiki'
Plug 'tools-life/taskwiki'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'blindFS/vim-taskwarrior'
Plug 'mattn/calendar-vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'pandoc', 'vimwiki','vim-plug']}
call plug#end()
colorscheme gruvbox
"}}}
