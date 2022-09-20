augroup accurate_syntax_highlight
  autocmd!
  autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
  autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
  au BufNewFile,BufRead /*.rasi setf css
augroup END

augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
augroup END

autocmd FileType javascript setlocal formatprg=prettier\ --stdin

function! DisableSTL()
  return ""
endfunction

augroup nvimTree
  autocmd!
  autocmd BufEnter NvimTree setlocal statusline=%!DisableSTL()
  autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
augroup END

autocmd FileType help wincmd L

augroup filetypedetect
  au! BufRead,BufNewFile *.csv,*.dat setfiletype csv
augroup END

augroup filetype_vimwiki
  autocmd!
  autocmd FileType vimwiki set syntax=pandoc
  autocmd FileType vimwiki nmap <CR> <Plug>VimwikiFollowLink
  autocmd FileType vimwiki vmap <CR> <Plug>ZettelNewSelectedMap
  autocmd FileType vimwiki nmap <S-CR> <Plug>VimwikiSplitLink
  autocmd FileType vimwiki nmap <C-CR> <Plug>VimwikiVSplitLink
  autocmd FileType vimwiki nmap + <Plug>VimwikiNormalizeLink
  autocmd FileType vimwiki vmap + <Plug>ZettelNewSelectedMap
  autocmd FileType vimwiki nmap <D-CR> <Plug>VimwikiTabnewLink
  autocmd FileType vimwiki nmap <C-S-CR> <Plug>VimwikiTabnewLink
  autocmd FileType vimwiki nmap <BS> <Plug>VimwikiGoBackLink
  autocmd FileType vimwiki nmap <TAB> <Plug>VimwikiNextLink
  autocmd FileType vimwiki nmap <S-TAB> <Plug>VimwikiPrevLink
  autocmd FileType vimwiki nmap <leader>wn <Plug>VimwikiGoto
  autocmd FileType vimwiki nmap <leader>wd <Plug>VimwikiDeleteFile
  autocmd FileType vimwiki nmap <leader>wr <Plug>VimwikiRenameFile
  autocmd FileType vimwiki nmap <C-Down> <Plug>VimwikiDiaryNextDay
  autocmd FileType vimwiki nmap <C-Up> <Plug>VimwikiDiaryPrevDay
  autocmd FileType vimwiki imap <silent> [[ [[<esc><Plug>ZettelSearchMap
  autocmd FileType vimwiki nmap T <Plug>ZettelYankNameMap
augroup END

augroup git_repo_check
  autocmd!
  autocmd VimEnter,DirChanged * call utils#Inside_git_repo()
augroup END


" GV
function! s:gv_expand()
   let line = getline('.')
   GV --name-status
   call search('\V'.line, 'c')
   normal! zz
endfunction
autocmd! FileType GV nnoremap <buffer> <silent> + :call <sid>gv_expand()<cr>
