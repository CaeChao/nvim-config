function custom#lightline#coc_diagnostic_error() abort "{{{
  let info = get(b:, 'coc_diagnostic_info', {})
  return get(info, 'error', 0) ==# 0 ? '' : "\uf00d" . info['error']
endfunction "}}}

function custom#lightline#coc_diagnostic_warning() abort "{{{
  let info = get(b:, 'coc_diagnostic_info', {})
  return get(info, 'warning', 0) ==# 0 ? '' : "\uf529" . info['warning']
endfunction "}}}

function custom#lightline#coc_diagnostic_ok() abort "{{{
  let info = get(b:, 'coc_diagnostic_info', {})
  if get(info, 'error', 0) ==# 0 && get(info, 'error', 0) ==# 0
    let msg = "\uf00c"
  else
    let msg = ''
  endif
  return msg
endfunction "}}}

function custom#lightline#coc_status() abort "{{{
  return get(g:, 'coc_status', '')
endfunction "}}}

function! custom#lightline#git_status()
  return FugitiveHead() .' '
endfunction

function! custom#lightline#disable_statusline()
  return " "
endfunction
