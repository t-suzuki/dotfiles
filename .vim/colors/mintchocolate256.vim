" Vim color file
" vim:sw=4:ts=4:noet:
" Maintainer: 7bit <uglydog.7bit@gmail.com>
" Last Change: 2007 Dec 29

" mintchocolate256 - dark background and pink & light green based foreground

set bg=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "mintchocolate256"

hi Normal		ctermfg=175 ctermbg=0
hi ErrorMsg		ctermfg=213 ctermbg=160
hi Visual		ctermfg=fg ctermbg=0 cterm=reverse
hi VisualNOS	ctermfg=fg ctermbg=0 cterm=reverse
hi LineNr		ctermfg=213 ctermbg=236
hi NonText		ctermfg=104 ctermbg=236

hi ModeMsg		ctermfg=111
hi MoreMsg		ctermfg=152
hi WarningMsg	ctermfg=red

hi Pmenu		ctermfg=213 ctermbg=88
hi PmenuSel		ctermfg=15 ctermbg=88
hi PmenuSbar	ctermfg=207 ctermbg=88
hi PmenuThumb	ctermfg=219

hi SpecialKey	ctermfg=103
hi Title		ctermfg=magenta cterm=bold
hi WildMenu		ctermfg=0 ctermbg=191 cterm=none
hi Question		ctermfg=green cterm=none
hi Directory	ctermfg=103

hi Cursor		ctermfg=black ctermbg=28
hi CursorIM		ctermfg=black ctermbg=30
hi lCursor		ctermfg=black ctermbg=white
hi CursorLine	cterm=underline

hi Todo			ctermfg=15 ctermbg=52
hi Error		ctermfg=15 ctermbg=201
hi Search		ctermfg=89 ctermbg=174 cterm=underline

hi DiffAdd		ctermfg=0 ctermbg=219 cterm=none
hi DiffChange	ctermfg=15 ctermbg=161 cterm=none
hi DiffDelete	ctermfg=blue ctermbg=239 cterm=none
hi DiffText		ctermfg=15 ctermbg=22 cterm=bold

hi StatusLine	ctermfg=125 ctermbg=213 term=none cterm=none
hi StatusLineNC	ctermfg=158 ctermbg=239 term=none cterm=none
hi VertSplit	ctermfg=158 ctermbg=239 term=none cterm=none

hi TabLine		ctermfg=15 ctermbg=241
hi TabLineFill	ctermfg=240 "fg for fill color
hi TabLineSel	ctermfg=15 ctermbg=199

hi Folded		ctermfg=251 ctermbg=53 cterm=bold term=bold
hi FoldColumn	ctermfg=251 ctermbg=0 cterm=bold term=bold

" syntax colors
hi Comment		ctermfg=177 ctermbg=238 cterm=none
hi Constant		ctermfg=141 cterm=none
hi Identifier	ctermfg=fg cterm=none
hi Function		ctermfg=202 cterm=none
hi Statement	ctermfg=254 cterm=none
hi Operator		ctermfg=15 cterm=none
hi Keyword		ctermfg=15 cterm=none
hi PreProc		ctermfg=86 cterm=none
hi Type			ctermfg=151 cterm=none
hi Special		ctermfg=138 cterm=none
hi Underlined	cterm=underline

