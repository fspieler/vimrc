:set number

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

"put red-lint at 80 characters
if exists('+colorcolumn')
  set colorcolumn=80
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

" Open, close, and enter pairs
noremap! "" ""<left>
noremap! '' ''<left>
 
noremap! (( ()<left>
noremap! (<cr> (<cr>)<c-o>O
noremap! (; ();<esc>hi
noremap! (<cr>; (<cr>);<c-o>O
noremap! ('; ('');<esc>hhi
noremap! ("; ("");<esc>hhi
noremap! (' ('')<esc>hi
noremap! (" ("")<esc>hi
 
noremap! {{ {}<left>
noremap! {<cr> {<cr>}<c-o>O
noremap! {; {};<esc>hi
noremap! {<cr>; {<cr>};<c-o>O
noremap! {'; {''};<esc>hhi
noremap! {"; {""};<esc>hhi
noremap! {' {''}<esc>hi
noremap! {" {""}<esc>hi
 
noremap! [[ []<left>
noremap! [<cr> [<cr>]<c-o>O
noremap! [; [];<esc>hi
noremap! [<cr>; [<cr>];<c-o>O
noremap! ['; [''];<esc>hhi
noremap! ["; [""];<esc>hhi
noremap! [' ['']<esc>hi
noremap! [" [""]<esc>hi
