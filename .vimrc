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
