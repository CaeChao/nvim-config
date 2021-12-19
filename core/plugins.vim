lua require('init')

" vinegar
let g:ranger_replace_netrw = 1
let g:NERDTreeHijackNetrw = 0
let g:ranger_map_keys = 0

" Markdown-preview
let g:mkdp_command_for_global = 0
let g:mkdp_refresh_slow = 1
let g:mkdp_filetypes = ['markdown', 'pandoc', 'vimwiki']

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

let g:vista_default_executive = 'ctags'
let g:vista_executive_for = {
      \ 'javascript': 'nvim_lsp',
      \ 'typescript': 'nvim_lsp',
      \ 'javascriptreact': 'nvim_lsp',
      \ 'typescriptreact': 'nvim_lsp',
      \ 'tsx': 'nvim_lsp',
      \ 'vimwiki': 'markdown',
      \ 'pandoc': 'markdown',
      \ 'markdown': 'toc',
      \ }

 let g:vista_ctags_cmd = {
    \ 'vimwiki': '~/.local/share/nvim/site/pack/packer/opt/taskwiki/extra/vwtags.py'
    \ }

let g:taskwiki_source_tw_colors="yes"
"}}
