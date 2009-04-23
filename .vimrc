" ------------------------------------------------------------
" 色設定

syntax on
colorscheme ron

"highlight LineNr ctermfg=darkyellow guifg=darkyellow
"highlight NonText ctermfg=darkgrey gui=NONE guifg=darkcyan
highlight Folded ctermfg=blue
highlight SpecialKey cterm=underline ctermfg=darkgrey guifg=darkcyan

"highlight Cursor ctermbg=darkyellow guibg=darkyellow
"highlight CursorIM ctermbg=red guibg=red

" カレントウィンドウにのみ罫線を引く
" 特にPHPで重いのでコメントアウト
"augroup cch
"  autocmd! cch
"  autocmd WinLeave * set nocursorcolumn nocursorline
"  autocmd WinEnter,BufRead * set cursorcolumn cursorline
"augroup END
"
"highlight CursorLine ctermbg=black guibg=black
"highlight CursorColumn ctermbg=black guibg=black

" tab
"----------------------------------------------------------
set ts=2 sw=2
set softtabstop=2
set expandtab
set listchars=tab:>-,eol:$,trail:*
set list
autocmd FileType python set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab nocindent

" edit
"-----------------------------------------------------------
set autoindent
set cindent
set backspace=indent,eol,start
set showmatch
set wildmenu
set formatoptions+=mM
set ambiwidth=double

set mouse=a
set ttymouse=xterm2

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

" omni complete
"-----------------------------------------------------------
hi Pmenu guibg=#666666
hi PmenuSel guibg=#8cd0d3 guifg=#666666
hi PmenuSbar guibg=#333333

" noh
nmap <ESC><ESC> :noh<CR>
cmap <ESC><ESC> <C-C>:noh<CR>

" insert CR
nnoremap <C-J> o<ESC>
nnoremap <CR> o<ESC>

" save if updated on double Leader
noremap <Leader><Leader> :up<CR>

" up/down
nnoremap <C-Y> jzz
nnoremap <C-E> kzz

" select/yank to line end
vnoremap v $h
nnoremap Y y$

" exit
nnoremap QQ :qa<CR>

" buffer next/prev
"-----------------------------------------------------------
nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>
nnoremap <S-Tab> :bp<CR>

" tab
"-----------------------------------------------------------
nnoremap <C-K>c :tabnew<CR>
nnoremap <C-K>d :tabclose<CR>
nnoremap <C-K><C-D> :tabclose<CR>
nnoremap <C-K>o :tabonly<CR>
nnoremap <C-K><C-O> :tabonly<CR>

nnoremap <C-K><C-P> gT
nnoremap <C-K>h gT
nnoremap <C-K><C-N> gt
nnoremap <C-K><C-K> gt
nnoremap <C-K>l gt
nnoremap <C-Tab> gt

" emacs keymap in command mode
"-----------------------------------------------------------
cmap <C-A> <Home>
cmap <C-E> <End>
cmap <C-F> <Right>
cmap <C-B> <Left>

