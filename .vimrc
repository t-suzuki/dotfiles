" vim: fenc=utf8 ts=2 sw=2 :

" syntax and colors
" ------------------------------------------------------------
if has("syntax")
  syntax on

  highlight NonText ctermfg=darkgrey gui=NONE guifg=darkcyan
  highlight Folded ctermfg=blue
  highlight SpecialKey cterm=underline ctermfg=darkgrey guifg=darkcyan

  highlight Cursor ctermbg=darkyellow guibg=darkyellow
  highlight CursorIM ctermbg=red guibg=red

  " 256color settings
  if &term=='xterm-256color' || &term=='xterm-debian'
    colorscheme ron
    silent! colorscheme orangeocean256
    "highlight Normal ctermbg=none
    "highlight NonText ctermbg=none
    highlight CursorLine cterm=none
  else
    colorscheme ron
    highlight CursorLine cterm=none ctermbg=darkgrey guibg=black
    highlight CursorColumn cterm=none ctermbg=none guibg=black
  endif

  if 0
  function! StressSyntaxSymbol()
    syntax match SyntaxSymbol /[!%^&()+|~[\]{};:,.<>?=-]/
    highlight SyntaxSymbol term=bold gui=bold

    syntax match JISX0208Space display '\u3000' containedin=ALL
    highlight JISX0208Space cterm=underline ctermfg=lightblue guibg=white
  endf
  " [  ]
  augroup sss
    autocmd! sss
    autocmd BufNewFile,BufRead * call StressSyntaxSymbol()
    autocmd BufNewFile,BufRead * match JISX0208Space "\u3000"
  augroup END
  endif

  " カレントウィンドウにのみ罫線を引く
  augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorcolumn nocursorline
    autocmd WinEnter,BufRead * set cursorcolumn cursorline
    " PHPで重いので使わない
    autocmd WinEnter,BufRead *.php set nocursorcolumn nocursorline
  augroup END

  highlight CursorLine ctermbg=darkblue guibg=#362231
  highlight CursorColumn ctermbg=darkblue guibg=#362231
endif


" auto open quickfix
"----------------------------------------------------------
silent! autocmd QuickFixCmdPost make,grep,grepadd,vimgrep copen

" filetype
"----------------------------------------------------------
filetype plugin indent on
autocmd FileType python set ts=4 sts=4 sw=4 noet noci si ai 
      \cinwords=if,elif,else,for,while,try,except,finally,def,class,with indentkeys+=#

autocmd FileType haskell set ts=2 sts=2 sw=2 et noci si ai indentkeys+=0--

let php_sql_query=1
let php_htmlInStrings=1
let php_folding=1
autocmd FileType php set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" autocmd BufNewFile,BufRead *.c,*.h,*.cpp,*.java,*.php inoremap {{{ {<CR><CR>}<Esc>k<Tab>
" autocmd BufRead *.c,*.h,*.cpp if search('<GL','n')>0|set dict=$VIMRUNTIME/dict/gl.dict|endif

" tabs, special chars
"----------------------------------------------------------
set expandtab tabstop=2 shiftwidth=2 softtabstop=2
set list listchars=tab:>-,eol:$,trail:*

" edit & looks
"-----------------------------------------------------------
set number
set scrolloff=5
set autoindent
set cindent
set backspace=indent,eol,start
set showmatch " show matching parentheses
set wildmenu
set formatoptions+=mM
set ambiwidth=double " for UTF-8 kigou
set hidden

" use mouse in terminal
set mouse=a
set ttymouse=xterm2

" 画面最下行の行を出来るだけ表示
set display=lastline

" command line, status, title
"-----------------------------------------------------------
set cmdheight=1
set showcmd
set laststatus=2
set title
au BufEnter * let &titlestring='%m '.expand("%:t")

" for vim 6 to 7
if v:version>700 | set statusline=\[%n%{bufnr('$')>1?'/'.bufnr('$'):''}%{winnr('$')>1?':'.winnr().'/'.winnr('$'):''}\]\ %<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l/%L,%c%V%8P
else | set statusline=\[%n%{bufnr('$')>1?'/'.bufnr('$'):''}\]\ %<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l/%L,%c%V%8P
endif

" search
"-----------------------------------------------------------
set hlsearch
set incsearch
set smartcase
set wrapscan

" windows
"-----------------------------------------------------------
set nosplitbelow
set splitright

" misc
"-----------------------------------------------------------
set modeline

" bells
set noerrorbells
set visualbell
set t_vb=

" encodings
set termencoding=utf-8
set encoding=utf-8
if has('win32')
  set fileencodings=cp932,iso-2022-jp,euc-jp,utf-8
else
  set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
endif
set fenc=utf-8

" browse
set browsedir=current
set shellslash

" fold
set foldmethod=indent
set foldlevelstart=99

"-----------------------------------------------------------
" keymaps
"-----------------------------------------------------------

" ========================= normal mode
" noh on ESCs
nnoremap <silent> <ESC><ESC> :noh<CR>

" move to the center of the line
noremap <expr> gm (virtcol('$')/2).'\|'

" insert CR
nnoremap <C-J> o<ESC>
"nnoremap <CR> o<ESC> " not good for quickfix window

" save if updated on double Leader
noremap <Leader><Leader> :up<CR>

" up/down prev/next => center
nnoremap <C-I> <C-I>zz
nnoremap <C-O> <C-O>zz

" yank to line end
nnoremap Y y$

" close fold on <Left> at the head of a line
nnoremap <expr> h foldlevel(getpos('.')[1])>0 &&
      \(getpos('.')[2]==1 \|\|
      \getline('.')[: getpos('.')[2]-2] =~ "^[\<TAB> ]*$" )?"zch":"h"

" exit
nnoremap QQ :qa<CR>

" buffer next/prev
nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>
nnoremap <S-Tab> :bp<CR>

" window prev (ref: window next: C-W C-W)
nnoremap <C-W><C-P> <C-W><S-W>

" vertical split and goto file
nnoremap <C-W><C-F> :<C-U>vs<CR>gf

" tab
nnoremap <C-?>c :tabnew<CR>
nnoremap <C-?>d :tabclose<CR>
nnoremap <C-?><C-D> :tabclose<CR>
nnoremap <C-?>o :tabonly<CR>
nnoremap <C-?><C-O> :tabonly<CR>
nnoremap <C-?><C-P> gT
nnoremap <C-?>h gT
nnoremap <C-?><C-N> gt
nnoremap <C-?><C-?> gt
nnoremap <C-?>l gt
nnoremap <C-Tab> gt

" re-visual on search
vnoremap <silent> gn <ESC>:<C-U>call search(@/)<CR>:<C-U>call search(@/, 'ces')<CR>v``
vnoremap <silent> gN <ESC>:<C-U>call search(@/, 'b')<CR>:<C-U>call search(@/, 'ces')<CR>v``
nnoremap <silent> gn :<C-U>call search(@/)<CR>:<C-U>call search(@/, 'ces')<CR>v``
nnoremap <silent> gN :<C-U>call search(@/, 'b')<CR>:<C-U>call search(@/, 'ces')<CR>v``
nmap     <silent> n  gn<ESC>
nmap     <silent> N  gN<ESC>

" quickfix next/prev
nmap <silent> <ESC>n :<C-U>cn<CR>
nmap <silent> <ESC>p :<C-U>cp<CR>

" ========================= visual mode
" select to line end
vnoremap v $h

" search under visual selection
vnoremap * y/<C-R>"<CR>
vnoremap # y?<C-R>"<CR>

" ========================= command mode
" emacs keymap
cmap <C-A> <Home>
cmap <C-E> <End>
cmap <C-F> <Right>
cmap <C-B> <Left>

" auto list on completion
cnoremap <C-L> <C-L><C-D>
" completion from history
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" expand path
cmap <C-G> <c-r>=expand('%:p:h')<cr>/
" expand file (not ext)
cmap <C-G><C-G> <c-r>=expand('%:p:r')<cr>

" ========================= insert mode
" YYYYMMDD, YYYYMMDD-HHMM
inoremap <F5> <C-r>=strftime('%Y%m%d')<CR>
inoremap <F6> <C-r>=strftime('%Y%m%d-%H%M')<CR>

" return to normal mode and suspend
inoremap <C-Z> <ESC><C-Z>

" move to line end
inoremap <C-L> <C-O>A

" emacs like C-K
inoremap <C-K> <ESC>lDa

"=====================================================================
" plugin settings
"=====================================================================

" VIM-LaTeX
" http://vim-latex.sourceforge.net/index.php
"-----------------------------------------------------------
set shellslash
if has('win32')
  set grepprg=grep\ -nH\ $*
  function! VimLaTeXInit()
    set noguipty " for dviout in gVim
    if &guioptions !~# 'm'
      set guioptions+=m
    endif
    let g:Tex_CompileRule_dvi='platex -src-specials -interaction=nonstopmode'
    let g:Tex_CompileRule_pdf='pdflatex -interaction=nonstopmode' " not working
    let g:Tex_CompileRule_ps='dvipsv -D600' " not working
    let g:Tex_DefaultTargetFormat = 'dvi'
    let g:Tex_ViewRule_dvi='dviout -1'
    let g:Tex_ViewRule_ps='gsview' " not working
    let g:Tex_ViewRule_pdf='f:\app\file\foxitreader\foxit reader.exe' " not working
  endf
  augroup vimlatexinit
    autocmd! vimlatexinit
    autocmd BufNewFile,BufRead *.tex setf tex_latexSuite|call VimLaTeXInit()
    autocmd BufNewFile *.tex <buffer> set enc=cp932
  augroup END
endif

" 2html
"-----------------------------------------------------------
let g:html_use_css=1
let g:html_use_xhtml=1

" autocomplpop
"-----------------------------------------------------------
" on Enter - close menu and new line
inoremap <expr> <CR> pumvisible()?"\<C-E>\<CR>":"\<CR>"
let g:AutoComplPop_IgnoreCaseOption=0

" changelog
" ------------------------------------------------------------
let g:changelog_timeformat="%Y-%m-%d %H:%M:%S"

" QFixHowm
" http://sites.google.com/site/fudist/Home/qfixhowm/
" ------------------------------------------------------------
if has('win32')
  let $HOWM_INSTALL_DIR=$VIMRUNTIME.'/qfixapp'
  let howm_dir='F:/home/howm'
else
  let $HOWM_INSTALL_DIR=$HOME.'/.vim/qfixapp'
  let howm_dir='~/howm'
endif

if filereadable($HOWM_INSTALL_DIR.'/plugin/myhowm.vim')
  set runtimepath+=$HOWM_INSTALL_DIR
  let howm_filename='%Y/%m/%Y%m%d-%H%M%S.howm'
  let howm_fileencoding='utf-8'
  let howm_fileformat='unix'
endif

"=====================================================================
" local settings
silent! execute "source ~/.vim_localrc_" . system("echo -n $(hostname)")
