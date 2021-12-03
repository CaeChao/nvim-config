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
