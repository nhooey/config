" Vim color file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2001 Jul 23

"set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

"colorscheme default
let g:colors_name = "gneil"

" hardcoded colors :
" GUI Comment : #80a0ff = Light blue

" GUI
highlight Normal		guifg=white		guibg=black
highlight Search		guifg=Black		guibg=grey		gui=bold
highlight Visual		guifg=Grey25	gui=bold
highlight Cursor		guifg=Black		guibg=Green		gui=bold
highlight Special		guifg=#eca3ec
highlight Comment		guifg=#7777FA
highlight StatusLine	guifg=blue		guibg=white
highlight Statement		guifg=#F6D66F	gui=NONE
highlight Type			guifg=#5EFF5E	gui=NONE
highlight PreProc		guifg=#FF74FF
highlight Todo			guifg=black		guibg=#F55454	gui=bold
highlight LineNr		guifg=#606060
highlight Constant		guifg=#F55454
highlight Number		guifg=#F55454

hi StatusLineNC guifg=gray   guibg=#202020  gui=none  ctermfg=black  ctermbg=gray  term=none  cterm=none
hi StatusLine   guifg=gray   guibg=#341717  gui=none  ctermfg=black  ctermbg=grey  term=none  cterm=none
hi VertSplit    guifg=black  guibg=#202020  gui=none  ctermfg=black  ctermbg=gray  term=none  cterm=none
hi Search       guifg=white  guibg=red      gui=none  ctermfg=white  ctermbg=red   term=none  cterm=none
hi MatchParen   guifg=white  guibg=blue     gui=none  ctermfg=white  ctermbg=blue  term=none  cterm=none

highlight green        ctermbg=green     guibg=green     ctermfg=black     guifg=black
highlight blue         ctermbg=blue      guibg=blue      ctermfg=black     guifg=black
highlight red          ctermbg=red       guibg=red       ctermfg=black     guifg=black
highlight yellow       ctermbg=yellow    guibg=yellow    ctermfg=black     guifg=black

" Diff Colours
highlight DiffAdd      ctermbg=black     guibg=#0c1427
highlight DiffChange   ctermbg=darkblue  guibg=#0c1427
highlight DiffText     ctermbg=black     guibg=#19316b
highlight DiffDelete   ctermbg=none      guibg=#292929   ctermfg=black   guifg=black
