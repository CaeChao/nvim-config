lua require('init')

" Markdown-preview
let g:mkdp_command_for_global = 1
let g:mkdp_open_to_the_world = 1
let g:mkdp_refresh_slow = 1
let g:mkdp_filetypes = ['markdown', 'pandoc', 'vimwiki']

"{{ VimWiki settings
let g:vimwiki_global_ext = 0
let g:vimwiki_dir_link = 'index'
let g:vimwiki_table_mappings = 0
let g:vimwiki_create_link = 0
let g:vimwiki_valid_html_tags = 'b,i,s,u,sub,sup,kbd,br,hr, pre, script'
let g:vimwiki_list = [{
                      \ 'path': '~/Documents/vimwiki',
                      \ 'diary_rel_path': '/',
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
