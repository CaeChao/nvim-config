" ============================================================================
" VIM-PLUG PLUGINS {{{
" ============================================================================

" set runtimepath+=~/.local/share/nvim/site/pack/ultisnips
let &packpath=&runtimepath

let g:is_linux = (has('unix') && !has('macunix')) ? v:true : v:false
let g:is_mac = has('macunix') ? v:true : v:false

let g:config_file_list = [
  \ 'settings.vim',
  \ 'plugins.vim',
  \ 'autocmds.vim',
  \ 'ui.vim',
  \ 'mappings.vim'
  \ ]

for s:fname in g:config_file_list
  execute printf('source %s/core/%s', stdpath('config'), s:fname)
endfor
