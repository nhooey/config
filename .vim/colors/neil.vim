" Vim color file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2001 Jul 23

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

"let colors_name = "neil"

hi StatusLineNC	guifg=gray  guibg=#202020 gui=none	ctermfg=gray	ctermbg=darkblue term=none cterm=none
hi StatusLine	guifg=gray  guibg=#341717 gui=none	ctermfg=gray	ctermbg=darkblue term=none cterm=none
hi VertSplit	guifg=black guibg=#202020 gui=none	ctermfg=gray	ctermbg=darkblue term=none cterm=none
hi Search		guifg=white guibg=red gui=none		ctermfg=white	ctermbg=red term=none cterm=none
hi MatchParen	guifg=white guibg=blue gui=none		ctermfg=white	ctermbg=blue term=none cterm=none

hi DiffAdd    guibg=slategray4 guifg=white gui=none ctermfg=white ctermbg=gray
hi DiffChange guibg=steelblue3 guifg=white gui=none ctermfg=white ctermbg=blue
hi DiffDelete guibg=slategray4 guifg=white gui=none ctermfg=white ctermbg=gray
hi DiffText   guibg=steelblue4 guifg=white gui=bold ctermfg=white ctermbg=blue
