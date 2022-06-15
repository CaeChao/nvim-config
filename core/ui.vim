let s:theme_packs = {}

function! s:theme_packs.gruvbox_material() dict abort 
  let g:gruvbox_material_background = 'medium'
  let g:gruvbox_material_foreground = 'material'
  let g:gruvbox_material_visual = 'grey background'
  let g:gruvbox_material_cursor = 'green'
  let g:gruvbox_material_sign_column_background = 'none'
  let g:gruvbox_material_better_performance = 1
  let g:gruvbox_material_enable_italic = 1
  let g:gruvbox_material_disable_italic_comment = 1
  colorscheme gruvbox-material
endfunction

function! s:theme_packs.everforest() dict abort
  let g:everforest_enable_italic = 1
  let g:everforest_better_performance = 1
  colorscheme everforest
endfunction

function! s:theme_packs.nightfox() dict abort
  colorscheme nordfox
  " colorscheme nightfox
endfunction

function! s:theme_packs.nvcode_gruvbox() dict abort
  let g:nvcode_termcolors=256
  colorscheme gruvbox
endfunction


let s:theme2dir = {
      \ 'gruvbox_material': 'gruvbox-material',
      \ 'nvcode_gruvbox': 'nvcode-color-schemes.vim',
      \ 'everforest' :'everforest',
      \ 'nightfox': 'nightfox.nvim'
      \ }

" let s:theme = utils#RandElement(keys(s:theme2dir))
let s:theme = 'gruvbox_material'
let s:colorscheme_func = printf('s:theme_packs.%s()', s:theme)

if !has_key(s:theme_packs, s:theme)
  let s:msg = "Invalid colorscheme function: " . s:colorscheme_func
  call v:lua.vim.notify(s:msg, 'error', {'title': 'nvim-config'})
  finish
endif


let s:res = utils#add_pack(s:theme2dir[s:theme])
if !s:res
  echomsg printf("Theme %s not installed. Run PackerSync to install.", s:theme)
  finish
endif

execute 'call ' . s:colorscheme_func
let s:msg1 = "Currently loaded theme: " . s:theme
call v:lua.vim.notify(s:msg1, 'info', {'title': 'nvim-config'})


