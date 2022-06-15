function! utils#RandInt(Low, High) abort
  " Use lua to generate random int. It is faster. Ref: https://stackoverflow.com/a/20157671/6064933
  call v:lua.math.randomseed(localtime())
  return v:lua.math.random(a:Low, a:High)
endfunction

" Selection a random element from a sequence/list
function! utils#RandElement(seq) abort
  let l:idx = utils#RandInt(0, len(a:seq)-1)

  return a:seq[l:idx]
endfunction


function! utils#add_pack(name) abort
  let l:success = v:true
  try
    execute printf("packadd! %s", a:name)
  catch /^Vim\%((\a\+)\)\=:E919/
    let l:success = v:false
  endtry

  return l:success
endfunction


" Check if we are inside a Git repo.
function! utils#Inside_git_repo() abort
  let res = system('git rev-parse --is-inside-work-tree')
  if match(res, 'true') == -1
    return v:false
  else
    " Manually trigger a specical user autocmd InGitRepo (to use it for
    " lazyloading of fugitive by packer.nvim).
    " See also https://github.com/wbthomason/packer.nvim/discussions/534.
    doautocmd User InGitRepo
    return v:true
  endif
endfunction

function! utils#GetGitBranch()
  let l:res = systemlist('git rev-parse --abbrev-ref HEAD')[0]
  if match(l:res, 'fatal') != -1
    return ''
  else
    return l:res
  endif
endfunction
