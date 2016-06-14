"line numbering
set number

"tab=4spaces
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

"auto word-wrap
set tw=99
set formatoptions+=t

"persistent visual mode after indent
vnoremap < <gv
vnoremap > >gv

"<ENTER> adds a blank line below
noremap <S-ENTER> O<ESC>j
noremap <ENTER> o<ESC>k

"Tab is the new auto-complete
function! SuperTab()
    if (strpart(getline('.'),col('.')-2,1)=~'^\W\?$')
        return "\<Tab>"
    else
        return "\<C-n>"
    endif
endfunction
imap <Tab> <C-R>=SuperTab()<CR>

"put red-line at 100 characters
if exists('+colorcolumn')
  set colorcolumn=100
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

"scrolling
set scrolloff=8     "Number of lines from vertical edge to start scrolling
set sidescrolloff=15 "Number of cols from horizontal edge to start scrolling
set sidescroll=1     "Number of cols to scroll at a time

"jump to last cursor position when opening file
autocmd BufReadPost *                                    
\ if line("'\"") > 0 && line ("'\"") <= line("$") |                             
\   exe "normal g'\"" |                                                         
\ endif

" Go to home and end using capitalized directions
noremap H ^
noremap L $

"move cursor by display lines
setlocal wrap linebreak nolist
set virtualedit=
setlocal display+=lastline
noremap <buffer> <silent> <Up> gk
noremap <buffer> <silent> <Down> gj
noremap <buffer> <silent> <Home> g<Home>
noremap <buffer> <silent> <End> g<End>
noremap <buffer> <silent> k gk
noremap <buffer> <silent> j gj
noremap <buffer> <silent> 0 g0
noremap <buffer> <silent> $ g$
inoremap <buffer> <silent> <Up> <C-o>gk
inoremap <buffer> <silent> <Down> <C-o>gj
inoremap <buffer> <silent> <Home> <C-o>g<Home>
inoremap <buffer> <silent> <End> <C-o>g<End>


" Originally based on Eric Vander Weele's ~/.vimrc

" Basics {

" turn off Vi compatibility and enforce strict Vim usage
set nocompatible

" disable reading of .vimrc, .exrc, and .gvimrc in the current directory
set noexrc

" set colors for the type of terminal background you are using
" values can be 'dark' or 'light'.  see which one you like best
"set background=light

highlight clear
if exists("syntax_on")
    syntax reset
endif
syntax on


"colors & fonts
colorscheme solarized
set background=dark
"set guifont=Console\ 12
"set guifont=Courier\ 18"
"colorscheme default

" enables use of file specific settings when using vim just add:
" /* vim: opt1=value1:opt2:value2: */
" in the first line or the last 5 (by default) lines of the file
set modeline

" if terminal support colors, enable or disable accordingly
if has('syntax') && (&t_Co > 2)
    syntax on
else
    syntax off
endif

" create $HOME/.vim directory if necessary
if finddir(".vim", $HOME) == ""
    call mkdir($HOME . "/.vim")
endif

" create $HOME/.vim/backup directory if necessary
if finddir("backup", $HOME . "/.vim") == ""
    call mkdir($HOME . "/.vim/backup")
endif

" create $HOME/.vim/tmp directory if necessary
if finddir("tmp", $HOME . "/.vim") == ""
    call mkdir($HOME . "/.vim/tmp")
endif

" }

" General {

" enable loading of the plugin/indent files for specific file types
filetype plugin indent on

" change the current working directory whenever you open  file, switch
" buffers, delete a buffer, or open/close a window
" set autochdir

" write contents of the file if it has been modified when executing other
" commands, switching buffers, or running something via command line
set autowrite

" allows backspacing over indentation, end-of-line, and at the start of
" insert.  This allows for backspace behavior of most normal editors
set backspace=indent,eol,start

" make a backup before overwriting a file.  file is left around after the file
" has been successfully written
set backup

" list of directories for the backup file, comma separated
" *NOTE: directory must exist, it won't be created
set backupdir=~/.vim/backup

" list of directory names for the swap file, comma separated
set directory=.,~/.vim/tmp

" <EOL> formats that will be tried in this order when starting to edit a new
" buffer and when reading a file into an existing buffer
set fileformats=unix,mac,dos

" have mouse control enabled all the time if terminal allows it
" set mouse=a

" don't ring the bell (beep/flash screen) for error messages
set noerrorbells

" command line completion operates in enhanced mode
set wildmenu

" list of file patterns to ignore when autocompleting file or directory names
set wildignore=*.o,*.gch,*.bak,*.pyc,
            \*.jpg,*.gif,*.png,*.dd,*.d

" cmd-line completion <Tab>; first list available options and complete the
" longest common part, then have further <Tab>'s cycle through possibilities
set wildmode=list:longest,full

" map <F5> to give the current time
map <F5> :echo 'Current time is ' . strftime('%c')<CR>

" }

" Restoring line position {
" restore cursor location to file position from previous session
" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='20,\"100,:20,%,n~/.viminfo

function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

"undofile
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

" }

" User Interface {

" highlight the screen column of the cursor.  will make screen redrawing
" slower
"set cursorcolumn

" highlight the screen line of the cursor.  will make screen redrawing slower
"set cursorline

" set highlighting options of the cursorlines
"hi CursorLine term=none cterm=bold ctermfg=none ctermbg=0

" only show status bar when there is more than 1 window, (0=never, 1=only one
" window, 2=always)
set laststatus=2

" list mode to show hidden characters (i.e. tabs, EOL, trailing space)
set list

" show tabs and trailing whitespace
set listchars=tab:>-,trail:-

" leave cursor on the same column, if possible, when using jump commands
set nostartofline

" disable visual bell flash when beeping
set novisualbell

" display line numbers
set number
set relativenumber

" minimal number of columns to use for the line number (default: 4)
set numberwidth=4

" always report number of lines changed when using commands (e.g., " :substitute)
set report=0

" show ruler at the bottom
set ruler

" minimal number of screen lines to keep above and below the cursor
set scrolloff=999 "very large to keep cursor middle of screen

" show (partial) command in status line
set showcmd

" disable when a bracket is inserted, briefly jump to the matching one
set noshowmatch

" if in Insert, Replace, or Visual mode...put message on the last line
set showmode

" minimal number of screen columns to keep to the left and right of the cursor
" if 'nowrap' is set
set sidescrolloff=1

" minimal number of lines for the current window (*Note: not a hard minimum)
set winheight=10

" minimal height of a window when it is not the current window
set winminheight=3


" Search {
" when on, the :substitute flag 'g' is default on (replace global)
set gdefault

" when there is a previous search pattern, highlight all its matches
set hlsearch

" while typing a search command, show where the pattern, as so far, matches
set incsearch

" ignore case in search patterns
set ignorecase

" override the ignorecase option if the search pattern contains upper case
" characters
set smartcase

" }

" Syntax Highlighting {

" Use 'tex' instead of 'plaintex' for LaTeX files
let g:tex_flavor = "latex"
" }

" }

" Text Formatting/Layout {

" copies indent from current line to starting new line, only useful if
" smartindent is on as well
set autoindent

" use spaces instead of \t character for tabs
set expandtab

" disables wrapping lines when it is greater than the window size
" *NOTE: This does NOT format any text, it is just helpful for viewing purposes
" set nowrap

" default number of spaces used at each step of indentation for '>>', '<<',
" auto-indent
set shiftwidth=4

" make the backspace <BS> treat # of spaces specified as a tab (i love this)
set softtabstop=4

" default number spaces that a <Tab> counts for
set tabstop=4

" function for setting number of spaces for leading indentation
function! SetTabSpaceSize(num_spaces)
    let &l:shiftwidth=a:num_spaces
    let &l:softtabstop=a:num_spaces
    let &l:tabstop=a:num_spaces
endfunction

" uses system call to determine minimum number of leading spaces, sets that
" number to use for indentation
function! DetectLeadingSpaces()
    let l:numspaces=system("egrep -o \"^\\s+\" " . @% ."| awk '{print length ($0); }' | sort -nu | head -n 1 ")
    if l:numspaces != 0
       call SetTabSpaceSize(l:numspaces)
    endif
endfunction

" call the above function when reading buffer
autocmd BufRead * call DetectLeadingSpaces()

" set of mappings for when auto-detection fails...
nnoremap <leader>1 :call SetTabSpaceSize(1)<cr>
nnoremap <leader>2 :call SetTabSpaceSize(2)<cr>
nnoremap <leader>3 :call SetTabSpaceSize(3)<cr>
nnoremap <leader>4 :call SetTabSpaceSize(4)<cr>
nnoremap <leader>8 :call SetTabSpaceSize(8)<cr>

" does 'smart' indenting based on basic programming language syntax structures
" ie. brackets, 'cinwords', and comments, etc
set smartindent

" when on a <Tab> in front of a line, inserts blanks according to shiftwidth
set smarttab

" automatically puts anything past ## characters onto the next line
" this may be invoked by the command 'gwj' which formats the line the cursor
" is on and puts the cursor on the next line (0 means to disable)
set textwidth=0

"highlight instances of the word under cursor
"v
"autocmd CursorMoved * silent! exe printf('match IncSearch /\<%s\>/', expand('<cword>'))
"set hlsearch

" C/C++ {

function! EnhanceCppSyntax()
    syn match cppFuncDef "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
    hi def link cppFuncDef Special
endfunction

"don't indent namespace content
":help cinoptions-values
set cino=N-s,L-1,g0
"N-s -> don't indent namespaces
"L-1 -> don't indent labels
"g0 -> don't indent private and public

" }

" }

" Folding {

" enable folding on opened files (files opened will be folded by default)
set nofoldenable

" the start and end marker used when 'foldmethod' is 'marker'
set foldmarker={,}

" use syntax file for default folding (could use 'marker')
" foldmethod=syntax
set foldmethod=marker

" folds with a higher level will be closed.  Higher numbers will close fewer
" folds
set foldlevel=0

" specify which type of commands open folds if the command moves the cursor
" into the fold
set foldopen+=jump

" python folding
augroup filetype_python
    autocmd!
    autocmd FileType python set foldmethod=indent
augroup END

" custom fold text function and settings (cleaner than default)
function SimpleFoldText() "{
    return getline(v:foldstart). ' '
endfunction "}
set foldtext=SimpleFoldText()

" }

" Autocommands {

" auto strip trailing whitespace to these file types on writes
"" autocmd BufWritePre *.c,*.cpp,*.h :%s/\s\+$//e

" FileType {

" custom tmux.conf filetype
au BufNewFile,BufRead tmux.conf set filetype=tmux_conf

" use the best indenting possible with c/c++ files, smartindent is ignored
" cindent is enabled
autocmd Filetype c,cpp,h set cindent

" in HTML, don't have a textwidth because it auto-wraps and is annoying
autocmd FileType html set textwidth=0 matchpairs+=<:>
autocmd FileType htmldjango set textwidth=0

" in Makefiles, don't expand tabs to spaces and reset the standard tab length
" because Makefiles require the indentation of tabs for targets
autocmd FileType make set noexpandtab shiftwidth=4
" }
" }

" Mappings {

" toggle to set paste/non-paste mode to ignore auto-indenting rules
set pastetoggle=<F2>

" toggle listing of hidden characters
nmap <silent> <F3> :set list!<CR>
imap <silent> <F3> <c-o>:set list!<CR>

" toggle hlsearch
nmap <silent> <F4> :set nohlsearch!<CR>
imap <silent> <F4> <c-o>:set nohlsearch!<CR>

nnoremap <leader>t :TlistToggle<CR><C-w>=
nnoremap <leader>g :TlistUpdate<CR>:TlistHighlightTag<CR>:TlistOpen<CR><C-w>=
nnoremap <leader>r :w<CR>:TlistUpdate<CR>:TlistHighlightTag<CR>

" navigate windows
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <leader>v <C-W><C-V><bar><C-W><C-L>:e<space>

" navigate visual lines
nnoremap j gj
nnoremap k gk

" tab navigation
nnoremap tn :tabn<CR>
nnoremap tc :tabc<CR>
nnoremap tp :tabp<CR>
nnoremap te :tabe<space>

" from normal mode, insert space and stay in normal mode
nnoremap <space> i <esc>

" autocomplete tab instead of Ctrl-N
" inoremap <tab> <C-N>
inoremap <tab> <tab>

" save
nnoremap <leader>w :wa<CR>

" edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" search and replace
nnoremap <leader>sr :%s/\<<c-r><c-w>\>/

" find whole word
nnoremap <leader>/ /\<\><left><left>

nnoremap `` ''
nnoremap '' ``

vnoremap < <gv
vnoremap > >gv
" }

" Open test file, header, and source file {
function! OpenCppFilesFunc(file_prefix)
    let s:s:minus_extension=split(a:file_prefix,'\.')[0]
    let s:alreadyopen=0
    "open cpp file
    if filereadable(s:minus_extension . ".cpp")
        exe "tabe " . s:minus_extension . ".cpp"
        let s:alreadyopen=1
    endif
    "open header
    if s:alreadyopen == 1
        exe "vsplit " . s:minus_extension . ".h"
    else
        exe "tabe " . s:minus_extension . ".h"
    endif
    "open test file... if not present, look in ../unit_test
    if filereadable(s:minus_extension . ".t.cpp")
        exe "vsplit " . s:minus_extension . ".t.cpp"
    else
        let s:file_name=split(fnamemodify(s:minus_extension,":p:."),"/")[-1]
        let s:split_path=split(fnamemodify(s:minus_extension,':p:.'),"/")
        if len(s:split_path) > 2
            let s:path=join(s:split_path[:-3],'/') . "/unit_test/" . s:file_name . ".t.cpp"
        elseif len(s:split_path) == 2
            let s:path="unit_test/" . s:file_name . ".t.cpp"
        else
            let s:path="../unit_test/" . s:file_name . ".t.cpp"
        endif
        if filereadable(s:path)
            exe "vsplit " . s:path
        else
            echo "No test found :("
        endif
    endif
endfunction

command! -complete=file -nargs=* OpenCppFiles :call OpenCppFilesFunc("<args>")

nnoremap <leader>] :OpenCppFiles<space>
" }

" VisualModeMacroHelper {
" Apply a single line macro to every selected line in visual mode
"
function! VisualModeMacro() range
    let l:char=nr2char(getchar())
    execute "'<,'>normal! @".l:char."\<cr>"
endfunction

vnoremap @ :call VisualModeMacro()<cr>

" }

" Relative Jump {
" This section makes it so that when I use <num>gk, it will leave a marker
" that I can jump back to easily.
" I use relativenumber so this makes it easy to jump around close to the
" cursor.
" The downside of using j, gj, k, and gk 'out-of-the-box' is that they don't
" leave markers.
function! RelativeJumpUp(count)
    execute "normal! m'".a:count."k"
endfunction
function! RelativeJumpDown(count)
    execute "normal! m'".a:count."j"
endfunction

command! -nargs=1 RelativeJumpCmdUp call RelativeJumpUp(<args>)
command! -nargs=1 RelativeJumpCmdDown call RelativeJumpDown(<args>)

nnoremap gk :<c-u>RelativeJumpCmdUp(v:count1)<cr>
nnoremap gj :<c-u>RelativeJumpCmdDown(v:count1)<cr>
" }

set tags+=./
