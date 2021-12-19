" Remap
inoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>
nnoremap ; :
let mapleader = "'"
let g:dispatch_no_maps = 1

" Leader shortcuts
nnoremap <leader>f 1z= 
nnoremap <leader>s :set spell!<CR>
nnoremap <leader>D :read !date<CR>
nnoremap <leader>t :Vista!!<CR>
nnoremap <leader>gq :%!pandoc -f html -t markdown<CR>
vnoremap <leader>gq :!pandoc -f markdown -t html<CR>
nnoremap <leader>n :NvimTreeToggle<CR>:wincmd p<CR>
nnoremap <leader>q :b#<bar>bd#<CR>

" Miscellaneous 
vnoremap . :norm.<CR>

" Movement/Navigation shortcuts
nnoremap j gj
nnoremap k gk
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" nnoremap <silent> <C-n> :bnext<CR>
" nnoremap <silent> <C-p> :bprevious<CR>
nnoremap <silent> <C-n> :BufferLineCycleNext<CR>
nnoremap <silent> <C-p> :BufferLineCyclePrev<CR>


" Clipboard functionality (paste from system)
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>d "+d
vnoremap <leader>d "+d
let g:highlightedyank_highlight_duration = 1000

" BufferLine
nnoremap <silent>>> :BufferLineMoveNext<CR>
nnoremap <silent><< :BufferLineMovePrev<CR>
nnoremap <leader>be :BufferLineSortByExtension<CR>
nnoremap <leader>bd :BufferLineSortByDirectory<CR>

" Telescope
nnoremap <silent> <leader><leader> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>a <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>gs <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <silent> <leader><Enter> <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <silent> <C-t> <cmd>lua require('telescope.builtin').current_buffer_tags()<cr>

" Trouble
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

" Markdown-preview
nmap <leader>mp <Plug>MarkdownPreview
nmap <leader>ms <Plug>MarkdownPreviewStop

" GV
function! s:gv_expand()
   let line = getline('.')
   GV --name-status
   call search('\V'.line, 'c')
   normal! zz
endfunction
autocmd! FileType GV nnoremap <buffer> <silent> + :call <sid>gv_expand()<cr>

" VimWiki
nnoremap <leader>gl :VimwikiGenerateLinks
nmap <leader>x <Plug>VimwikiToggleListItem
nnoremap <leader>c :Calendar<CR>
let g:taskwiki_maplocalleader="'tw"

