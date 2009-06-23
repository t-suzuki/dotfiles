" ------------------------------------------------------------
" 色設定

if has("syntax")
  syntax on

  "highlight LineNr ctermfg=darkyellow guifg=darkyellow
  highlight NonText ctermfg=darkgrey gui=NONE guifg=darkcyan
  highlight Folded ctermfg=blue
  highlight SpecialKey cterm=underline ctermfg=darkgrey guifg=darkcyan

  highlight Cursor ctermbg=darkyellow guibg=darkyellow
  highlight CursorIM ctermbg=red guibg=red

  " 256color settings
  if &term=='xterm-256color'
    silent! colorscheme orangeocean256
    "highlight Normal ctermbg=none
    "highlight NonText ctermbg=none
    highlight CursorLine cterm=none
  else
    colorscheme ron
    highlight CursorLine cterm=none ctermbg=darkgrey guibg=black
    highlight CursorColumn cterm=none ctermbg=none guibg=black
  endif

  " カレントウィンドウにのみ罫線を引く
  augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorcolumn nocursorline
    autocmd WinEnter,BufRead * set cursorcolumn cursorline
    " PHPで重いので使わない
    autocmd WinEnter,BufRead *.php set nocursorcolumn nocursorline
  augroup END
endif


" filetype specific
"----------------------------------------------------------
filetype plugin indent on
autocmd FileType python set ts=4 sts=4 sw=4 noet noci si ai cinwords=if,elif,else,for,while,try,except,finally,def,class,with indentkeys+=#
autocmd FileType haskell set ts=2 sts=2 sw=2 et noci si ai indentkeys+=0--

" tab
"----------------------------------------------------------
set et ts=2 sw=2 sts=2
set list listchars=tab:>-,eol:$,trail:*

" edit
"-----------------------------------------------------------
set autoindent
set cindent
set backspace=indent,eol,start
set showmatch " show matching parentheses
set wildmenu
set formatoptions+=mM
set ambiwidth=double " for UTF-8 kigou

" use mouse in terminal
set mouse=a
set ttymouse=xterm2

" highlight, incremental
set hlsearch
set incsearch

set statusline=\[%n%{bufnr('$')>1?'/'.bufnr('$'):''}%{winnr('$')>1?':'.winnr().'/'.winnr('$'):''}\]\ %<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l/%L,%c%V%8P

set number
set laststatus=2

set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
set fenc=utf-8

set browsedir=current
set shellslash

set scrolloff=5

" 画面最下行の行を出来るだけ表示
set display=lastline

" completion
"-----------------------------------------------------------
" close menu and new line
inoremap <expr> <CR> pumvisible()?"\<C-Y>\<CR>":"\<CR>"

"-----------------------------------------------------------
" keymaps
"-----------------------------------------------------------

" ========================= normal mode
" noh on ESCs
nmap <ESC><ESC> :noh<CR>

" graphical j/k (dangerous for scripts)
"nnoremap j gj
"nnoremap k gk

" insert CR
nnoremap <C-J> o<ESC>

" save if updated on double Leader
noremap <Leader><Leader> :up<CR>

" up/down prev/next => center
nnoremap <C-I> <C-I>zz
nnoremap <C-O> <C-O>zz

" yank to line end
nnoremap Y y$

" exit
nnoremap QQ :qa<CR>

" buffer next/prev
nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>
nnoremap <S-Tab> :bp<CR>

" window prev (ref: window next: C-W C-W)
nnoremap <C-W><C-P> <C-W><S-W>

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

" noh on ESCs
cmap <ESC><ESC> <C-C>:noh<CR>


" ========================= insert mode
" YYYYMMDD, YYYYMMDD-HHMM
inoremap <F5> <C-r>=strftime('%Y%m%d')<CR>
inoremap <F6> <C-r>=strftime('%Y%m%d-%H%M')<CR>

" return to normal mode and suspend
inoremap <C-Z> <ESC><C-Z>

" move to line end
inoremap <C-L> <C-O>A

" --------------------- commentout.vim ---------------------
" lhs comments
vmap ,/ :s/^/\/\//<CR>:nohlsearch<CR>:'<,'>s/^\/\//\1/e<CR>:noh<CR>
vmap ," :s/^/\"/<CR>:nohlsearch<CR>:'<,'>s/^\"\"/\1/e<CR>:noh<CR>
vmap ,% :s/^/%/<CR>:nohlsearch<CR>:'<,'>s/^%%/\1/e<CR>:noh<CR>
vmap ,- :s/^/--/<CR>:nohlsearch<CR>:'<,'>s/^----/\1/e<CR>:noh<CR>
vmap ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>

" " block comments
vmap ,b v`<I<CR><esc>k0i/*<ESC>`>j0i*/<CR><esc><ESC>
vmap ,h v`<I<CR><esc>k0i<!--<ESC>`>j0i--><CR><esc><ESC>


"-----------------------------------------------------------
" local settings
:execute "source ~/.vim_localrc_" . system("echo -n $(hostname)")

