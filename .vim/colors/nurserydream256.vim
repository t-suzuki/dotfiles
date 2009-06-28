" Vim color file
" vim:sw=4:ts=4:noet:
" Maintainer: 7bit <uglydog.7bit@gmail.com>
" Last Change: 2009 06 28

" nurserydream256 - pink background based

set bg=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "nurserydream256"

hi Normal		ctermfg=0 ctermbg=225
hi ErrorMsg		ctermfg=213 ctermbg=160
hi Visual		ctermfg=13 ctermbg=15
hi VisualNOS		ctermfg=13 ctermbg=253
hi LineNr		ctermfg=57 ctermbg=81
hi NonText		ctermfg=11 ctermbg=219

hi ModeMsg		ctermfg=111
hi MoreMsg		ctermfg=152
hi WarningMsg	ctermfg=9

hi Pmenu		ctermfg=255 ctermbg=213
hi PmenuSel		ctermfg=0 ctermbg=226 cterm=bold
hi PmenuSbar	ctermfg=207 ctermbg=253
hi PmenuThumb	ctermfg=248

hi SpecialKey	ctermfg=24
hi Title		ctermfg=magenta cterm=bold
hi WildMenu		ctermfg=0 ctermbg=191 cterm=none
hi Question		ctermfg=green cterm=none
hi Directory	ctermfg=103

hi Cursor		ctermfg=black ctermbg=231
hi CursorIM		ctermfg=black ctermbg=30
hi lCursor		ctermfg=black ctermbg=white
hi CursorLine	cterm=none ctermbg=219
hi CursorColumn	cterm=none ctermbg=219

hi Todo			ctermfg=15 ctermbg=52
hi Error		ctermfg=15 ctermbg=201
hi Search		ctermfg=0 ctermbg=226 cterm=bold

hi DiffAdd		ctermfg=0 ctermbg=228 cterm=none
hi DiffDelete	ctermfg=243 ctermbg=233 cterm=none
hi DiffChange	ctermfg=15 ctermbg=33 cterm=none
hi DiffText		ctermfg=15 ctermbg=22 cterm=bold

hi StatusLine	ctermfg=0 ctermbg=226 term=none cterm=none
hi StatusLineNC	ctermfg=232 ctermbg=81 term=none cterm=none
hi VertSplit	ctermfg=255 ctermbg=81 term=none cterm=none

hi TabLine		ctermfg=233 ctermbg=75
hi TabLineFill	ctermfg=237 "fg for fill color
hi TabLineSel	ctermfg=15 ctermbg=27

hi Folded		ctermfg=233 ctermbg=195 cterm=bold term=bold
hi FoldColumn	ctermfg=251 ctermbg=0 cterm=bold term=bold

" syntax colors
hi Comment		ctermfg=201 ctermbg=228 cterm=none
" Constant
hi String		ctermfg=26 cterm=none
hi Character	ctermfg=88 cterm=none
hi Number		ctermfg=18 cterm=none
hi Boolean		ctermfg=18 cterm=none
hi Float		ctermfg=18 cterm=none
"Identifier
hi Function		ctermfg=30 cterm=none
hi Identifier		ctermfg=30 cterm=none
" Statement
hi Conditional	ctermfg=58 cterm=none
hi Repeat		ctermfg=160 cterm=none
hi Label		ctermfg=160 cterm=none
hi Operator		ctermfg=57 cterm=bold
hi Keyword		ctermfg=57 cterm=none
hi Exception	ctermfg=197 cterm=none
hi Statement	ctermfg=167 cterm=none

hi PreProc		ctermfg=92 cterm=none
hi Type			ctermfg=9 cterm=none
hi Special		ctermfg=90 cterm=bold
hi Underlined	cterm=underline



