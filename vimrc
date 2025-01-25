"___________________
"___________________
"Start up settings
"___________________
"___________________



" backups and swap directories
silent !mkdir ~/.nvim > /dev/null 2>&1
silent !mkdir ~/.nvim/backup > /dev/null 2>&1
silent !mkdir ~/.nvim/swap > /dev/null 2>&1
silent !mkdir ~/.nvim/undo > /dev/null 2>&1
set backupdir=~/.nvim/backup//
set directory=~/.nvim/swap//
set undodir=~/.nvim/undo//

" sane text files
set fileformat=unix
set encoding=utf-8
set fileencoding=utf-8


" filetype recognition
filetype on
filetype plugin indent on

"button to enter my command mode
let mapleader = ","

" Don't redraw while executing macros (good performance config)
set lazyredraw 

"change buffers without saving
set hidden

"start scrolling after 16 lines
set scrolloff=8

" turn on line numbering
set number

" relative numbering for how many lines above and below
set relativenumber

" line number margin
set numberwidth=8

" Command bar height
set cmdheight=1

"show command as its being typed (bottom right)
set showcmd

" Display a confirmation dialog when closing unsaved files
set confirm

" clickable mouse
set mouse=a

" code folding
set foldmethod=indent
set foldlevel=99

" No sounds when hitting end of line
set noerrorbells

" word movement
imap <S-Left> <Esc>bi
nmap <S-Left> b
imap <S-Right> <Esc><Right>wi
nmap <S-Right> w



" Show matching brackets when text indicator is over them
set showmatch 

"timeout of key sequence
set notimeout

"project specific vimrc
set exrc
set secure

" Delete inserted text after leaving insert
set backspace=indent,eol,start

" restore place in file from previous session
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif






"___________________
"___________________
"Plugins
"___________________
"___________________

"if plug is not installed, install it.
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif


call plug#begin()


    " better status line
    Plug 'itchyny/lightline.vim'
    " bufferline
    Plug 'mengelbrecht/lightline-bufferline'

    " Auto completion
    Plug 'ycm-core/YouCompleteMe'

    " commenting
    Plug 'preservim/nerdcommenter'

    ""Highlight yanked text
    Plug 'machakann/vim-highlightedyank'

    "file tree
    Plug 'preservim/nerdtree' 

    "" color scheme
    Plug 'vim-python/python-syntax'


    Plug 'mattn/emmet-vim'


call plug#end()




""___________________
""___________________
""Lightline settings
""___________________
""___________________


" always show the status bar
set laststatus=2

" lightline config
let g:lightline = {
        \ 'active': {
        \   'left': [ [ 'mode',], ['filename',],  ],
        \   'right': [ ['lineinfo'] ]
        \ },
        \ 'inactive': {
        \   'left': [['inactive', 'filename']],
        \   'right': []
        \ },
        \ 'component': {
        \   'inactive': 'INACTIVE'
        \ },
        \ 'tabline': {
        \   'left': [ ['buffers'] ],
        \   'right': [],
        \ },
        \ 'component_expand': {
        \   'buffers': 'lightline#bufferline#buffers'
        \ },
        \ 'component_type': {
        \   'buffers': 'tabsel'
        \ }
        \ }

" dont duplicate mode in the command line (will still show in lightline)
set noshowmode


"___________________
"___________________
"Bufferline settings
"___________________
"___________________




" always show tabline
set showtabline=2

"show buffnumbers
let g:lightline#bufferline#show_number=2

" clickable bufferline (only neovim)
let g:lightline.component_raw = {'buffers': 1}
let g:lightline#bufferline#clickable = 1



" move left/right through buffers
nmap <leader>[ :bp!<CR>
nmap <leader>] :bn!<CR>

" move to specific
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)



function MyClose()
    " if the window split is the left most window and there is more then 1
    " window (if the window is NERDTree) 
    " OR (||)
    " There is only one buffer open
    if (winnr() == winnr('h') && winnr('$') > 1)|| len(getbufinfo({'buflisted':1})) ==1  |
        "quit normally
        execute 'q'
    "if the window split is for code (and there is more then one buffer open)
    else |
        "move to the next buffer and close the previous bufffer
        execute 'bp'
        execute 'bd #'
    endif
endfunction

ca q :call MyClose()



" close specific buffer
nmap <Leader>qb1 <Plug>lightline#bufferline#delete(1)
nmap <Leader>qb2 <Plug>lightline#bufferline#delete(2)
nmap <Leader>qb3 <Plug>lightline#bufferline#delete(3)
nmap <Leader>qb4 <Plug>lightline#bufferline#delete(4)
nmap <Leader>qb5 <Plug>lightline#bufferline#delete(5)
nmap <Leader>qb6 <Plug>lightline#bufferline#delete(6)
nmap <Leader>qb7 <Plug>lightline#bufferline#delete(7)
nmap <Leader>qb8 <Plug>lightline#bufferline#delete(8)
nmap <Leader>qb9 <Plug>lightline#bufferline#delete(9)
nmap <Leader>qb0 <Plug>lightline#bufferline#delete(10)




"___________________
"___________________
"NERDTree settings
"___________________
"___________________

"ignore these files and folders
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
"minimal ui settings
let NERDTreeMinimalUI = 1
"do not open tree if no file is given, just open vim homepage
let g:nerdtree_open = 0


" toggle nerd tree 
nnoremap <C-t> :NERDTreeToggle<CR>:NERDTreeRefreshRoot<CR>


" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif



let NERDTreeMapQuit = ''
let NERDTreeMapRefreshRoot= 'r'
let NERDTreeAutoDeleteBuffer = 1


"___________________
"___________________
"Indentation settings
"___________________
"___________________

" guess indentation levels
set smartindent

"use spaces instead of tabs
set expandtab
"new line above and below has same indentations
set autoindent


" tab lengths
set tabstop=4
set shiftwidth=4
set softtabstop=4
autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType css setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2


" indent/unindent with tab/shift-tab
nmap <Tab> >>
nmap <S-tab> <<
imap <S-Tab> <Esc><<i
vmap <Tab> >gv
vmap <S-Tab> <gv







"___________________
"___________________
"Wrap settings
"___________________
"___________________

" no wrapping of lines initially
set nowrap

"toggle wrap
nmap <C-w> :set wrap!<CR>


"___________________
"___________________
"Search and Replace Settings
"___________________
"___________________


" Searching, detect case sensitivity and search while typing
set smartcase
set incsearch
"This unsets the /last_search_pattern register by hitting return
nnoremap <CR> :noh<CR><CR>




"___________________
"___________________
"Copy/paste settings
"___________________
"___________________

" disable autoindent when pasting text
" source: https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

" copy, cut and paste
set clipboard=unnamedplus
inoremap <C-v> <ESC>"+pa
vnoremap <C-c> "+y


"___________________
"___________________
"Splits settings
"___________________
"___________________


" specify screen splits
set splitbelow
set splitright

" horizontal split
ca hsp sp

""move through split windows
"nmap <leader><Up> :wincmd k<CR>
"nmap <leader><Down> :wincmd j<CR>
"nmap <leader><Left> :wincmd h<CR>
"nmap <leader><Right> :wincmd l<CR>

"nmap <leader>k :wincmd k<CR>
"nmap <leader>j :wincmd j<CR>
"nmap <leader>h :wincmd h<CR>
"nmap <leader>l :wincmd l<CR>


"___________________
"___________________
"General highlighting
"___________________
"___________________
"



" turn on sytax
syntax enable


" enable 256 colors
set t_Co=256
set termguicolors

"command for identifying syntax highlighting group
command SynID  echo synIDattr(synID(line("."), col("."), 1), "name")
nmap <leader>s :SynID<CR>



"color a column to indicate if a line is too long
set colorcolumn=80

"base colorscheme
colorscheme evening

"general elements
highlight Normal guifg=#cfcfcf guibg=#1d1d1d ctermfg=white ctermbg=black 
highlight LineNr guifg=#999999 guibg=#1d1d1d ctermfg=darkgrey ctermbg=black 
highlight ColorColumn guibg=#333333 ctermbg=black 
highlight EndOfBuffer guibg=#1d1d1d ctermbg=black 

" used by highlight-yanked plugin to show yanked text
highlight IncSearch guifg=#ffffff guibg=#222222 ctermfg=white ctermbg=black





"___________________
"___________________
"HTML syntax
"___________________
"___________________


"html tag
set matchpairs+=<:>


"___________________
"___________________
"Python syntax highlighting
"___________________
"___________________
"
"


" use flake 8 for syntax
let g:syntastic_python_checkers=['flake8']

fun! SetPyMatch()
    syn match myPy /\%(match:\)\|\%(case:\)/
    hi link myPy pythonConditional
endfu
autocmd bufenter * :call SetPyMatch()
autocmd filetype * :call SetPyMatch()





" turn on highlighting for python objects
let python_highlight_all=1
" turn off highlighting for operators
let python_highlight_operators=0





""python highlighting
highlight pythonComment guifg=#994444 guibg=#1d1d1d ctermfg=red ctermbg=black 
highlight pythonString guifg=#19aa1c guibg=#1d1d1d ctermfg=green ctermbg=black 
highlight pythonFString guifg=#19aa1c guibg=#1d1d1d ctermfg=green ctermbg=black 
highlight pythonQuotes guifg=#19aa1c guibg=#1d1d1d ctermfg=green ctermbg=black 
highlight pythonFunction guifg=#2b83db guibg=#1d1d1d ctermfg=blue ctermbg=black 
highlight pythonClass guifg=#2b83db guibg=#1d1d1d ctermfg=blue ctermbg=black 
highlight pythonDecorator guifg=#22eeee guibg=#1d1d1d ctermfg=cyan ctermbg=black 
highlight pythonDottedName guifg=#22eeee guibg=#1d1d1d ctermfg=cyan ctermbg=black 
highlight pythonFunctionCall guifg=#22eeee guibg=#1d1d1d ctermfg=cyan ctermbg=black 
highlight pythonFloat guifg=#efc402 guibg=#1d1d1d ctermfg=yellow ctermbg=black 
highlight pythonNumber guifg=#efc402 guibg=#1d1d1d ctermfg=yellow ctermbg=black 
highlight pythonBoolean guifg=#c17228 guibg=#1d1d1d ctermfg=darkyellow ctermbg=black 
highlight pythonNone guifg=#c17228 guibg=#1d1d1d ctermfg=darkyellow ctermbg=black 
highlight pythonOperator guifg=#c17228 guibg=#1d1d1d ctermfg=darkyellow ctermbg=black 
highlight pythonImport guifg=#c17228 guibg=#1d1d1d ctermfg=darkyellow ctermbg=black 
highlight pythonStatement guifg=#c17228 guibg=#1d1d1d ctermfg=darkyellow ctermbg=black 
highlight pythonRepeat guifg=#c17228 guibg=#1d1d1d ctermfg=darkyellow ctermbg=black 
highlight pythonConditional guifg=#c17228 guibg=#1d1d1d ctermfg=darkyellow ctermbg=black 
highlight pythonException guifg=#c17228 guibg=#1d1d1d ctermfg=darkyellow ctermbg=black 
highlight pythonExClass guifg=#c17228 guibg=#1d1d1d ctermfg=darkyellow ctermbg=black 
highlight pythonExClass guifg=#c17228 guibg=#1d1d1d ctermfg=darkyellow ctermbg=black 
highlight pythonExClass guifg=#c17228 guibg=#1d1d1d ctermfg=darkyellow ctermbg=black 

highlight pythonBuiltinType guifg=#9328c1 guibg=#1d1d1d ctermfg=magenta ctermbg=black 
highlight pythonBuiltinFunc guifg=#9328c1 guibg=#1d1d1d ctermfg=magenta ctermbg=black 
highlight pythonInclude guifg=#9328c1 guibg=#1d1d1d ctermfg=magenta ctermbg=black 
highlight pythonBuiltin guifg=#9328c1 guibg=#1d1d1d ctermfg=magenta ctermbg=black 
highlight pythonBuiltinObj guifg=#9328c1 guibg=#1d1d1d ctermfg=magenta ctermbg=black 
highlight pythonClassVar guifg=#9328c1 guibg=#1d1d1d ctermfg=magenta ctermbg=black 

highlight pythonBytesEscape guifg=#88dd88 guibg=#1d1d1d ctermfg=green ctermbg=black 
highlight pythonStrFormat guifg=#88dd88 guibg=#1d1d1d ctermfg=green ctermbg=black 

