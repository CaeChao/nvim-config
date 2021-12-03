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

autocmd FileType vimwiki set syntax=markdown.pandoc

function! DisableSTL()
  return ""
endfunction
au BufEnter NvimTree setlocal statusline=%!DisableSTL()
