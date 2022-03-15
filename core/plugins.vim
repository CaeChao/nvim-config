lua require('init')

" vinegar
let g:ranger_replace_netrw = 1
let g:NERDTreeHijackNetrw = 0
let g:ranger_map_keys = 0

" Markdown-preview
let g:mkdp_command_for_global = 1
let g:mkdp_open_to_the_world = 1
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
let g:vimwiki_dir_link = 'index'
let g:vimwiki_table_mappings = 0
let g:vimwiki_create_link = 0
let g:vimwiki_valid_html_tags = 'b,i,s,u,sub,sup,kbd,br,hr, pre, script'
let g:vimwiki_list = [{
                      \ 'path': '~/Documents/vimwiki',
                      \ 'path_html': '~/Documents/vimwiki/wiki_html',
                      \ 'template_path': '~/Documents/vimwiki/templates',
                      \ 'template_default': 'def_template',
                      \ 'template_ext': '.html',
                      \ 'syntax': 'markdown', 
                      \ 'ext': '.md',
                      \ 'auto_tags': 1,
                      \ 'generated_links_caption':1,
                      \ 'custom_wiki2html': '~/Documents/vimwiki/wiki2html.sh',
                      \ 'nested_syntaxes': {'python': 'python', 'c++': 'cpp'}
                      \ }]
let g:vimwiki_key_mappings =
    \ {
    \   'links': 0,
    \ }
let g:zettel_format = "%title"
let g:zettel_link_format= "[[%link]]"
let g:zettel_default_mappings = 0
let g:zettel_date_format = "%Y-%m-%d"


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
