
if has('syntax')
  syntax on
  colorscheme ron
  silent! colorscheme orangeocean256gui
endif

"-----------------------------------------------------------
" no (visual) bell
set visualbell t_vb=

" window perferences
"-----------------------------------------------------------
set guioptions-=T
set guioptions-=m
set guioptions+=c
set guioptions-=r " scroll bars
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b

if has('win32')
  set lines=88 columns=240
  set guifont=BDF_UM+:h9:i:cSHIFTJIS,Osaka－等幅:h9:cSHIFTJIS,
        \ＭＳ_ゴシック:h9:cSHIFTJIS
else
  set lines=35 columns=100
  set guifont=Bitstream\ Vera\ Sans\ Mono\ 11,さざなみゴシック\ Medium\ 10,
        \M+2VM+IPAG\ circle\ 10,Kochi\ Gothic\ 10
endif

" fullscreen (win32 only)
"-----------------------------------------------------------
if has('win32')
  nnoremap <F11> :call ToggleFullScreen()<CR>
  function! ToggleFullScreen()
    if &guioptions =~# 'C'
      set guioptions-=C
      if exists('s:go_temp')
        if s:go_temp =~# 'm'
          set guioptions+=m
        endif
        if s:go_temp =~# 'T'
          set guioptions+=T
        endif
      endif
      simalt ~r
    else
      let s:go_temp = &guioptions
      set guioptions+=C
      set guioptions-=m
      set guioptions-=T
      simalt ~x
    endif
  endfunction
endif

" for KaoriYa vim
let g:no_gvimrc_example = 1

if has('unix')
  " ------------------------------------------------------------
  " gVimのメニュー文字化け対策
  source $VIMRUNTIME/delmenu.vim
  set langmenu=menu_ja_jp.utf-8.vim
  source $VIMRUNTIME/menu.vim
endif

" vim: fenc=utf8 ts=2 sw=2 :
