"""""""""""""""""""""""""""""""""""""""""""""""""
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
Helptags

""""""""""""""""""""""""""""""""""""""""""""""""
" Generic setup
""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on

let mapleader = ","

""""""""""""""""""""""""""""""""""""""""""""""""
" Status line stuff - vim-airline
""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2                    " always show the status line

let g:airline#extensions#tabline#enabled=1

"""""""""""""""""""""""""""""""
" => Syntastic stuff
"""""""""""""""""""""""""""""""
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=0
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_python_checks = ['flake8']
let g:syntastic_python_flake8_args = '--ignore="E501,E2,E3"'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Open up the errors
nnoremap <leader>e :Error<cr>
nnoremap <leader>syn :SyntasticCheck<cr>

" Goto the next/previous error
nnoremap <leader>ne :lnext<cr>
nnoremap <leader>pe :lprev<cr>

"""""""""""""""""""""""""""""""
" => Tabular stuff - see http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
"""""""""""""""""""""""""""""""
if exists(":Tabularize")
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:\zs<CR>
    vmap <Leader>a: :Tabularize /:\zs<CR>

endif

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

"""""""""""""""""""""""""""""""
" => Ultisnips stuff
"""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""
" Turn on the Wild menu
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
" Always show current position
set ruler
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" Find words as typing out search
set incsearch
" Enable extended % matching
runtime macros/matchit.vim
" Start scrolling before cursor hits top/bottom
set scrolloff=5
" Number of lines to jump when scrolling off screen
" -# = percentage
set scrolljump=-10

" Set the paste toggle
map <F10> :set paste<cr>
map <F11> :set nopaste<cr>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>
set pastetoggle=<F11>

""""""""""""""""""""""""""""
" => Tags
""""""""""""""""""""""""""""
" setup tags
set tags=./tags;/

""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" set 256 terminal support
set t_Co=256

" Set the background to dark
set background=dark

" Configure solarized colorscheme
let g:solarized_termtrans=1
colorscheme solarized

" Quick funtion that will
" highlight over 80 columns
autocmd FileType cpp :autocmd! BufWritePre * :match ErrorMsg '\%>80v.\+'

" Use Unix as the standard file type
set ffs=unix,mac,dos

" Set the mouse to always show
set mouse=a
set nomh

""""""""""""""""""""""""""""
" => Files, backups and undo
""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc.
set nobackup
set nowb
set noswapfile

" Auto change directory
set acd

" Echo the full path of file being edited
nnoremap <leader>f :echo expand('%:p')<cr>

" Source and Edit vimrc
nnoremap <leader>src :source ~/.vimrc<cr>
nnoremap <leader>erc :vsp ~/.vimrc<cr>

" Sudo save a file
nnoremap <leader>save :w !sudo dd of=%<cr>

""""""""""""""""""""""""""""
" => Perforce mappings
""""""""""""""""""""""""""""
nnoremap <leader>p4e :!p4 edit %<cr>
nnoremap <leader>p4a :!p4 add %<cr>
nnoremap <leader>p4r :!p4 revert %<cr>
nnoremap <leader>p4l :!p4 login<cr>
nnoremap <leader>p4s :!p4 submit %<cr>
nnoremap <leader>p4d :!p4 diff %<cr>

""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Do not expand tab for Makefiles
autocmd FileType make set noexpandtab

" Be smart when using tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Auto indent and wrap lines
set ai
set wrap

" Set the backspace to work as expected
set backspace=2

" Auto remove trailing whitespace on write
autocmd BufWritePre * :%s/\s\+$//e

"""""""""""""""""""""""""""""""""""
" Window Management Stuff
"""""""""""""""""""""""""""""""""""
" Move to next or previous tab
nnoremap <leader>T :tabn<cr>
nnoremap <leader>P :tabp<cr>

" Increase and Decrease the width of a vertically split window
nnoremap <leader>< :vertical resize -10<cr>
nnoremap <leader>> :vertical resize +10<cr>

"""""""""""""""""""""""""""""""""""
" Operator Maps
"""""""""""""""""""""""""""""""""""
" Operator maps to get inside () '' and "
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap in) :<c-u>normal! F)vi)<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap in} :<c-u>normal! F}vi}<cr>
onoremap in[ :<c-u>normal! f[vi[<cr>
onoremap in] :<c-u>normal! F]vi]<cr>
onoremap in' :<c-u>normal! f'vi'<cr>
onoremap il' :<c-u>normal! F'vi'<cr>
onoremap in" :<c-u>normal! f"vi"<cr>
onoremap il" :<c-u>normal! F"vi"<cr>

"""""""""""""""""""""""""""""""""""
" Plugin Maps
"""""""""""""""""""""""""""""""""""
" Toggle TagBar
nnoremap <F8> :TagbarToggle<cr>
" Move to the TagBar if already opened or open and focus
" close the TagBar after selection
nnoremap <leader>tag :TagbarOpen fjc<cr>

" Toggle NERDTree
nnoremap <F6> :NERDTreeToggle<cr>
" List Tasks
nnoremap <leader>l :TaskList<cr>

"""""""""""""""""""""""""""""""""""
" Nice Abbreviations
"""""""""""""""""""""""""""""""""""
" ViaSat Header
iabbrev _VSH <ESC>:r /share/users/akinsley/vsat-header.txt<CR>kdd/Filename:<CR>A       <C-R>=expand("%")<CR><ESC>jA UNCLASSIFIED<ESC>/Copyright (C)<CR>//e<CR><ESC>llcw<C-R>=strftime("%Y")<CR><ESC>/^#\*\*<CR>:noh<CR>



