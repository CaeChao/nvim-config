call plug#begin(fnamemodify(stdpath('data'), ':p') . 'site/pack')
" Navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-vinegar'
if executable('ctags')
    " plugin to manage your tags
    Plug 'ludovicchabant/vim-gutentags'
    " show file tags in vim window
    Plug 'majutsushi/tagbar', { 'on': ['TagbarToggle', 'TagbarOpen'] }
endif
" Status/Tabline Bar
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'akinsho/bufferline.nvim'
" Coding
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
  \ 'coc-tslint',
  \ 'coc-tsserver',
  \ 'coc-emoji',
  \ 'coc-vimlsp',
  \ 'coc-xml',
  \ 'coc-yank',
  \ 'coc-json',
  \ 'coc-python',
  \ 'coc-java'
  \ ]
Plug 'windwp/nvim-autopairs'
Plug 'lukas-reineke/indent-blankline.nvim'
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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
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
Plug 'tpope/vim-fugitive'
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/gv.vim'
" Others
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'machakann/vim-highlightedyank'
Plug 'vimwiki/vimwiki'
Plug 'tools-life/taskwiki'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'blindFS/vim-taskwarrior'
Plug 'mattn/calendar-vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'pandoc', 'vimwiki','vim-plug']}
call plug#end()
"}}}
"
command PU PlugUpdate | PlugUpgrade | CocUpdate
" Airline settings
" let g:airline_theme = 'gruvbox_material'
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 0
" let g:airline#extensions#tabline#buffer_nr_show = 1
" let g:airline#extensions#coc#enabled = 1
" let g:airline#extensions#branch#enabled = 1

" let g:airline_detect_spell=0
" let g:airline_detect_spelllang=0
" let g:airline_left_sep = "\ue0b8"
" let g:airline_right_sep= "\ue0be"

" {{ lightline settings
let g:lightline = {
    \ 'enable': {
    \     'statusline': 1,
		\     'tabline': 0
    \ },
    \'colorscheme': 'gruvbox_material',
    \'separator': { 'left': "\ue0b8", 'right': "\ue0be" },
    \'subseparator': { 'left': "\ue0b9", 'right': "\ue0b9" },
    \'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \           [ 'gitbranch', 'readonly', 'filename', 'modified'] ],
    \   'right': [ [ 'lineinfo' ],
    \            [ 'linter_errors', 'linter_warnings', 'linter_ok' ],
    \           [ 'fileformat', 'coc_status' ] ]
    \ },
    \'component': {
    \ 'lineinfo': '%2p%% %3l:%-2v'
    \},
    \'component_function': {
    \   'gitbranch': 'custom#lightline#git_status',
    \   'coc_status': 'custom#lightline#coc_status'
    \ },
    \'component_expand': {
    \   'linter_warnings': 'custom#lightline#coc_diagnostic_warning',
    \   'linter_errors': 'custom#lightline#coc_diagnostic_error',
    \   'linter_ok': 'custom#lightline#coc_diagnostic_ok',
    \ },
    \'component_type': {
    \   'linter_warnings': 'warning',
    \   'linter_errors': 'error'
    \ },
    \}

"}}
" {{ Bufferline
lua << EOF
require("bufferline").setup{
  options = {
    diagnostics = "coc",
    separator_style = "slant",
    offsets = {
      {
        filetype = "NvimTree",
        text = 'Explorer',
        highlight = "Directory",
        text_align = "center"
      }
    },
  }
}
EOF

"}}

"{{ Tree-sitter
lua <<EOF
require('nvim-treesitter.configs').setup{
  ensure_installed = {"javascript", "typescript", "python", "lua", "vim"},
  highlight = {
    enable = true,
    disable = {}
  }
}
EOF
"}}

"{{ nvim-autopairs
lua <<EOF
require('nvim-autopairs').setup{
  disable_filetype = {"TelescopePrompt", "vim" },
}
EOF
"}}

" indent-blankline
lua <<EOF
require("indent_blankline").setup {
    char = "|",
    show_end_of_line = true,
    space_char_blankline = " ",
    filetype_exclude = {"markdown", 'pandoc', 'vimwiki', "help"}
}
EOF
"}}

" NERDTree
" let NERDTreeMinimalUI=1 " Disable bookmark and 'press ? for help' text

" NvimTree
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }
let g:nvim_tree_respect_buf_cwd = 1
let g:nvim_tree_auto_close = 1
let g:nvim_tree_root_folder_modifier = ':t'
let g:nvim_tree_hijack_cursor = 0
let g:nvim_tree_hijack_netrw = 0
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile


" vinegar
let g:ranger_replace_netrw = 1
let g:NERDTreeHijackNetrw = 0
let g:ranger_map_keys = 0

" Markdown-preview
let g:mkdp_command_for_global = 0
let g:mkdp_refresh_slow = 1
let g:mkdp_filetypes = ['markdown', 'pandoc', 'vimwiki']

" fzf find
set rtp+=~/.fzf
let g:fzf_preview_window = ['right:50%', 'ctrl-_']
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, $AG_DEFAULT_OPTIONS, fzf#vim#with_preview(), <bang>0)

"{{ Coc settings
command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 Eslint :CocCommand eslint.executeAutofix
" Highlight the symbol and its references when holding the cursor.
"}}

"{{ ALE FORMATTERS settings
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

"{{ UltiSnips settings 
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsEnableSnipMate = 0
let g:UltiSnipsJumpForwardTrigger='<TAB>'
let g:UltiSnipsJumpBackwardTrigger='<S-TAB>'
"}}

"{{ gutentags settings
let g:gutentags_cache_dir = stdpath('cache') . '/ctags'
let g:gutentags_add_default_project_roots = 0
let g:gutentags_generate_on_write = 1
let g:gutentags_project_root = ['.root', '.svn', '.git', 'package.json']
"}}

"{{ VimWiki settings
let g:vimwiki_global_ext = 0
let g:vimwiki_table_mappings=0
let g:vimwiki_list = [{
                      \ 'path': '~/MyArchive/vimwiki',
                      \ 'template_default': 'default',
                      \ 'syntax': 'markdown', 'ext': '.md',
                      \ 'auto_tags': 1,
                      \ 'nested_syntaxes': {'python': 'python', 'c++': 'cpp'}
                      \ }]
let g:tagbar_type_vimwiki = {
          \   'ctagstype':'vimwiki'
          \ , 'kinds':['h:header']
          \ , 'sro':'&&&'
          \ , 'kind2scope':{'h':'header'}
          \ , 'sort':0
          \ , 'ctagsbin':'~/.local/share/nvim/site/pack/taskwiki/extra/vwtags.py'
          \ , 'ctagsargs': 'markdown'
          \ }
let g:taskwiki_source_tw_colors="yes"
"}}
