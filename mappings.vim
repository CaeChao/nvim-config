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
nnoremap <leader>t :TagbarToggle<CR>
nnoremap <leader>gq :%!pandoc -f html -t markdown<CR>
vnoremap <leader>gq :!pandoc -f markdown -t html<CR>
nnoremap <leader>n :NvimTreeToggle<CR>:wincmd p<CR>
" nnoremap <leader>n :NERDTreeToggle<CR>:wincmd p<CR>
" nnoremap <leader>N :NERDTreeCWD<CR>
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

" CtrlSpace
let g:CtrlSpaceDefaultMappingKey = "<C-space> "

" BufferLine
nnoremap <silent>>> :BufferLineMoveNext<CR>
nnoremap <silent><< :BufferLineMovePrev<CR>
nnoremap <leader>be :BufferLineSortByExtension<CR>
nnoremap <leader>bd :BufferLineSortByDirectory<CR>

" fzf 
" nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <C-t> :Tags<CR>
nnoremap <leader>a :Ag

"" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Markdown-preview
nmap <leader>mp <Plug>MarkdownPreview
nmap <leader>ms <Plug>MarkdownPreviewStop


" Coc
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

function! s:coc_confirm() abort
  if pumvisible()
    return coc#_select_confirm()
  else
    return "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  endif
endfunction
" <CR> to handle completion
inoremap <silent> <CR> <C-r>=<SID>coc_confirm()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'

nnoremap <silent> F :call CocAction('format')<CR>

" navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation Remap.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>do <Plug>(coc-codeaction)

" GV
function! s:gv_expand()
   let line = getline('.')
   GV --name-status
   call search('\V'.line, 'c')
   normal! zz
endfunction
autocmd! FileType GV nnoremap <buffer> <silent> + :call <sid>gv_expand()<cr>

" JSDOC
nmap <leader>jd ?function<cr>:noh<cr><Plug>(jsdoc)

" VimWiki
nnoremap <leader>gl :VimwikiGenerateLinks
nmap <leader>x <Plug>VimwikiToggleListItem
nnoremap <leader>c :Calendar<CR>
let g:taskwiki_maplocalleader="'tw"

