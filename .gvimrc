" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

source ~/.vimrc

" You can also specify a different font, overriding the default font
if has('gui_gtk2')
	set guifont=Bitstream\ Vera\ Sans\ Mono\ 9
elseif has('gui_macvim')
	set guifont=Monaco:h10
" set guifont=Fira\ Code:h12
else
	set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1
endif

" If you want to run gvim with a dark background, try using a different
" colorscheme or running 'gvim -reverse'.
" http://www.cs.cmu.edu/~maverick/VimColorSchemeTest/ has examples and
" downloads for the colorschemes on vim.org

" Source a global configuration file if available
" XXX Deprecated, please move your changes here in /etc/vim/gvimrc
if filereadable("/etc/vim/gvimrc.local")
	source /etc/vim/gvimrc.local
endif

set guioptions-=T
set noantialias

" Prevent window from resizing on focus
:setglobal guioptions-=L
:setglobal guioptions-=l
:setglobal guioptions-=R
:setglobal guioptions-=r
:setglobal guioptions-=b
:setglobal guioptions-=h
