" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

colorscheme torte
hi Pmenu    guifg=white guibg=darkblue
hi PmenuSel	guifg=white guibg=blue

set cursorline
augroup CursorLine
	au!
	au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
	au WinLeave * setlocal nocursorline
augroup END
hi CursorLine   cterm=NONE ctermbg=darkred  guibg=darkred
hi CursorColumn cterm=NONE ctermbg=darkred  guibg=darkred
hi SignColumn              ctermbg=darkgrey guibg=#222222
hi Pmenu        ctermfg=15 ctermbg=13       guibg=DarkBlue
hi PmenuSel     ctermfg=15 ctermbg=0        guibg=Blue

if has("gui_macvim")
	set macmeta
endif

" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'nhooey/tabname'
Bundle 'sollidsnake/vterm'
Bundle 'vim-scripts/DetectIndent'
Bundle 'vim-scripts/Align'
Bundle 'mileszs/ack.vim'
Bundle 'vim-scripts/vcscommand.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'chrisbra/NrrwRgn'
Bundle 'thisivan/vim-bufexplorer'
Bundle 'airblade/vim-gitgutter'
Bundle 'lepture/vim-jinja'
Bundle 'rking/ag.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'wookiehangover/jshint.vim'
Bundle 'vim-scripts/gitignore'
Bundle 'puppetlabs/puppet-syntax-vim'

filetype plugin indent on

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
	\| exe "normal g'\"" | endif
    au BufReadPost * :DetectIndent
endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
if has("autocmd")
	filetype on
	filetype plugin on
	filetype indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
"set ignorecase     " Do case insensitive matching
set smartcase       " Do smart case matching
"set incsearch      " Incremental search
set autowrite       " Automatically save before commands like :next and :make
"set hidden         " Hide buffers when they are abandoned
set mouse=a         " Enable mouse usage (all modes) in terminals
set laststatus=2

" Remove mouse open from netrw
let g:netrw_mousemaps = 0

set hlsearch
set shiftwidth=4
set tabstop=4
let netrw_altv=1
set ruler
set noequalalways
set pastetoggle=<F12>
set visualbell
set bs=2
set wildmode=longest,list
set smartcase
set smartindent

" No backup or swap files
set nobackup
set nowritebackup
set noswapfile

" Always sync syntax highlighting at least 200 lines back
syntax sync minlines=800

" Use 256 Colors
set t_Co=256

" Window key bindings
nn <M-k> <C-w>k
nn <M-j> <C-w>j
nn <M-h> <C-w>h
nn <M-l> <C-w>l

" Make shift-insert work like in Xterm
map  <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Buffer navigation shortcuts
nn mk :cprev<CR>
nn ml :cnext<CR>
nn mo :clist!<CR>
nn mp :clist<CR>
nn gb :blast<CR>
nn do :diffget 1<CR>
nn dp :diffget 3<CR>

" FuzzyFinder
nn <Tab>   :FufFile<CR>
nn <S-Tab> :FufFile **/<CR>
let g:fuf_maxMenuWidth = 200



" for yaml, always use two spaces to indent
autocmd FileType yaml,yml set expandtab tabstop=2 shiftwidth=2

" Clear Search term
nmap <silent> ,/ :let @/=""<CR>

" Shutterstock ctags
set tags=tags,lib/tags,task-deployment/lib/tags

" Highlight questionable whitespace differently depending on expandtab
" -----------------------------------------------------------------------------
highlight QuestionableWhitespace ctermbg=black guibg=#333333
autocmd BufNewFile,BufRead * call HighlightWhitespace()
function! HighlightWhitespace()
	if &expandtab
		" highlight tabs not at the beginning of the line (but allow # for
		" comments and % for mason), and trailing whitespace not followed by
		" the cursor (maybe think about highlighting leading spaces not in
		" denominations of tabstop?)
		match QuestionableWhitespace /\(^[%#]\?\t*\)\@<!\t\|[ \t]\+\(\%#\)\@!$/
	else
		" highlight any leading spaces (TODO: ignore spaces in formatted
		" assignment statements), " tabs not at the beginning of the line (but
		" allow # for comments and % for mason), " and trailing whitespace not
		" followed by the cursor
		match QuestionableWhitespace /^ \+\|\(^[%#]\?\t*\)\@<!\t\|[ \t]\+\(\%#\)\@!$/
	endif
endfunction
" -----------------------------------------------------------------------------

" Remap F3 to do FuzzyFinder
noremap <F3> :FufFile **/<CR>

" Remap tab to autocomplete words when not at the beginning of a line
function! InsertTabWrapper()
	let col = col('.') - 1
	if !col || getline('.')[col - 1] !~ '\k'
		return "\<tab>"
	else
		return "\<c-p>"
	endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" Comment line toggle with 'X'
" -----------------------------------------------------------------------------
" see http://www.perlmonks.org/?node_id=561215 for more info
function! ToggleComment()
	let comment_start = '#'
	let comment_end   = ''

	if &filetype == 'sql'
		let comment_start = '--'
	endif
	if &filetype == 'vim'
		let comment_start = '"'
	endif
	if &filetype == 'css'
		let comment_start = '\/\* '
		let comment_end   = ' \*\/'
	endif
	if &filetype == 'javascript'
		let comment_start = '\/\/'
	endif

	" if the comment start is at the beginning of the line and isn't followed
	" by a space (i.e. the most likely form of an actual comment, to keep from
	" uncommenting real comments
	if getline('.') =~ ('^' . comment_start . '\( \w\)\@!')
		execute 's/^' . comment_start . '//'
		execute 's/' . comment_end . '$//'
	else
		s/^/\=comment_start/
		s/$/\=comment_end/
	endif
endfunction
map <silent> X :call ToggleComment()<cr>j
" -----------------------------------------------------------------------------

" Super Star Search
" -----------------------------------------------------------------------------
function! CmdLine(str)
	exe "menu Foo.Bar :" . a:str
	emenu Foo.Bar
	unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
	let l:saved_reg = @"
	execute "normal! vgvy"

	let l:pattern = escape(@", '\\/.*$^~[]')
	let l:pattern = substitute(l:pattern, "\n$", "", "")

	if a:direction == 'b'
		execute "normal ?" . l:pattern . "^M"
	elseif a:direction == 'gv'
		call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
	elseif a:direction == 'f'
		execute "normal /" . l:pattern . "^M"
	endif

	let @/ = l:pattern
	let @" = l:saved_reg
endfunction

"Basically you press * or # to search for the current selection
vnoremap <silent> *  :call VisualSearch('f')<CR>
vnoremap <silent> #  :call VisualSearch('b')<CR>
vnoremap <silent> gv :call VisualSearch('gv')<CR>
" -----------------------------------------------------------------------------

function! VisualHighlight(match, group) range
	execute "normal! vgvy"

	let l:pattern = escape(@", '\\/.*$^~[]')
	let l:pattern = substitute(l:pattern, "\n$", "", "")
	let l:pattern = '/' . l:pattern . '/'

	execute a:match 'match ' a:group ' ' l:pattern
endfunction

vnoremap <c-c>1 :call VisualHighlight(1, 'green')<CR>
vnoremap <c-c>2 :call VisualHighlight(2, 'blue')<CR>
vnoremap <c-c>3 :call VisualHighlight(3, 'yellow')<CR>
"vnoremap <c-a>1 :execute '1match' none<CR>
"vnoremap <c-a>2 :execute '2match' none<CR>
"vnoremap <c-a>3 :execute '3match' none<CR>

" Arduino specific settings
au BufRead,BufNewFile *.pde set filetype=cpp

" Undo reloading of a file
" -----------------------------------------------------------------------------
function! s:ReloadFilePreserveUndo()
	" Load content of new file into a list of lines. Note that without last
	" argument (1) it may fail to load file that does not contain "\n"
	" character, and may consume last "\n" character
	try
		let filecontents=readfile(expand('%'), 1)
	catch
		" We return 0 on error
		return 0
	endtry
	" Get the number of lines
	let fclen=len(filecontents)
	" If number of lines was reduced
	if fclen<line('$')
		" Delete some last lines to “black hole” register in order to leave
		" registers untouched
		execute fclen.",$d _"
		" Join previous change with call setline() so that reloading can be
		" undone in one step
		undojoin
	endif
	" Overwrite lines with new contents. That does not move cursor.
	" It returns 0 on success, so we need to invert that
	let r=!setline(1, filecontents)
	" Indicate that file was not modified: buffer contents after reload is equal
	" to file contents
	set nomodified
	return r
endfunction
"
" " Defined the editor command 'Reload' to call ReloadFilePreserveUndo
command! -nargs=0 Reload call s:ReloadFilePreserveUndo()
"
" " Automatically reload files when they change externally
au FileChangedShell * Reload
" -----------------------------------------------------------------------------
