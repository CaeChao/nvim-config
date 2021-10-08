augroup accurate_syntax_highlight
  autocmd!
  autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
  autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
  au BufNewFile,BufRead /*.rasi setf css
augroup END

autocmd CursorHold * silent call CocActionAsync('highlight')

autocmd FileType javascript setlocal formatprg=prettier\ --stdin

autocmd FileType vimwiki set syntax=markdown.pandoc

" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"
" au BufEnter * if bufname('%') == "NvimTree" | set statusline='%{custom#lightline#disable_statusline()}' | endif
