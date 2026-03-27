" =============================================================================
" 1. SYSTEM & DIRECTORIES 
" =============================================================================
let s:vim_dir = expand('~/.vim')
for s:subdir in ['backup', 'swap', 'undo']
    let s:target = s:vim_dir . '/' . s:subdir
    if !isdirectory(s:target)
        call mkdir(s:target, "p")
    endif
endfor

set backupdir=~/.vim/backup// 
set directory=~/.vim/swap// 
set undodir=~/.vim/undo// 
set undofile

" =============================================================================
" 2. PLUGINS & AUTO-INSTALL 
" =============================================================================
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
    Plug 'itchyny/lightline.vim' 
    Plug 'mengelbrecht/lightline-bufferline' 
    "Plug 'ycm-core/YouCompleteMe' 
    Plug 'preservim/nerdcommenter' 
    Plug 'machakann/vim-highlightedyank' 
    Plug 'preservim/nerdtree' 
    Plug 'vim-python/python-syntax' 
    Plug 'tidalcycles/vim-tidal' 
call plug#end()

" =============================================================================
" 3. CORE SETTINGS 
" =============================================================================
filetype plugin indent on 
syntax enable 
let mapleader = "," 

set encoding=utf-8 
set hidden 
set lazyredraw 
set mouse=a 
set confirm 
set termguicolors 
set noshowmode 
set laststatus=2    " Always show status line
set showtabline=2   " Always show tabline (for bufferline)
set foldmethod=indent
set foldlevel=99
set noerrorbells

" show matching brackets
set showmatch
"timeout of key sequence
set notimeout

" allow project specifc vimrcs
set exrc
set secure

" Numbers and UI 
set number 
set relativenumber 
set scrolloff=8 
set colorcolumn=80 
set cmdheight=1
set numberwidth=6
set showcmd

" Tabs and Search 
set expandtab 
set shiftwidth=4 
set tabstop=4 
set smartcase 
set incsearch 

" Delete inserted text after leaving insert
set backspace=indent,eol,start


" restore place in file from previous session
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif






" =============================================================================
" 4. MAPPINGS & LOGIC 
" =============================================================================
nmap <S-Left> b
nmap <S-Right> w
nmap <leader>[ :bp!<CR>
nmap <leader>] :bn!<CR>


" leader x to go to buffer x
for i in range(1, 9)
exe 'nmap <Leader>'.i.' <Plug>lightline#bufferline#go('.i.')'
endfor

function! MyClose()
if (winnr() == winnr('h') && winnr('$') > 1) || len(getbufinfo({'buflisted':1})) == 1 
        quit 
    else
        bp | bd # 
    endif
endfunction
ca q :call MyClose()

nnoremap <C-t> :NERDTreeToggle<CR>


"" Ctrl+C to copy in Visual Mode
vnoremap <leader>copytext "+y

"" Ctrl+V to paste in Normal and Insert Mode
nnoremap <leader>pastetext "+p

" =============================================================================
" LIGHTLINE
" =============================================================================


" Lightline + Bufferline Integration
let g:lightline = {
    \ 'colorscheme': 'jellybeans',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'tabline': {
    \   'left': [ [ 'buffers' ] ],
    \   'right': [ [ 'close' ] ]
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers'
    \ },
    \ 'component_type': {
    \   'buffers': 'tabsel'
    \ }
    \ }

let g:lightline#bufferline#show_number = 2




" =============================================================================
" GENERAL HIGHLIGHTING
" =============================================================================


" " add this to help Vim recognize the tmux override
if &term =~# '256color'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

syntax on
colorscheme evening  
highlight Normal       guifg=#cfcfcf guibg=#1d1d1d
highlight LineNr       guifg=#999999 guibg=#1d1d1d
highlight ColorColumn  guibg=#333333 
highlight EndOfBuffer  guifg=#ffffff guibg=#1d1d1d


" command for identifying highlight terms
command! SynID echo synIDattr(synID(line("."), col("."), 1), "name")
nmap <leader>s :SynID<CR>




" =============================================================================
" RUST CUSTOM HIGHLIGHTING
" =============================================================================

" Magenta (Calls and Macros)
highlight rustFuncCall      guifg=#ffaaff
highlight rustFuncName      guifg=#ffaaff
highlight rustMacro         guifg=#ffaaff

" Cyan (Structure and Keywords)
highlight rustKeyword       guifg=#88ffff
highlight rustStructure     guifg=#88ffff

" Green (Types and Traits)
highlight rustStorage       guifg=#88dd88
highlight rustType          guifg=#88dd88
highlight rustTrait         guifg=#88ee88
highlight rustEnumVariant   guifg=#88ee88

" Yellow (Strings)
highlight rustString          guifg=#efc402
highlight rustStringDelimiter guifg=#efc402

" White/Off-White (Logic, Numbers, and Identifiers)
highlight rustOperator      guifg=#eeeeee
highlight rustModPath       guifg=#eeeeee
highlight rustModPathSep    guifg=#eeeeee
highlight rustConditional   guifg=#eeeeee
highlight rustFloat         guifg=#eeeeee
highlight rustRepeat        guifg=#eeeeee
highlight rustDecNumber     guifg=#eeeeee
highlight rustSelf          guifg=#eeeeee
highlight rustIdentifier    guifg=#eeeeee
highlight rustSigil         guifg=#eeeeee
highlight rustQuestionMark  guifg=#eeeeee
highlight rustLifetime      guifg=#eeeeee




" =============================================================================
" PYTHON CUSTOM HIGHLIGHTING
" =============================================================================


" Enable all python highlighting features
let g:python_highlight_all = 1

" If you are using the 'vim-python/python-syntax' plugin specifically:
let g:python_highlight_builtins = 1
let g:python_highlight_builtin_funcs = 1
let g:python_highlight_builtin_types = 1

" Logic for match/case keywords 
syn match pythonCustomConditional /\%(match:\)\|\%(case:\)/
hi link pythonCustomConditional pythonConditional

" Normal 
highlight pythonOperator     guifg=#ffffff

" Reds (comments) 
highlight pythonComment      guifg=#994444

" Matrix green (strings) 
highlight pythonString       guifg=#19aa1c
highlight pythonFString      guifg=#19aa1c
highlight pythonQuotes       guifg=#19aa1c

" Light green (extra string stuff) 
highlight pythonBytesEscape  guifg=#88ff88
highlight pythonBytesContent guifg=#88ff88
highlight pythonStrFormat    guifg=#88ff88
highlight pythonRawString    guifg=#88ff88

" Blue (definitions) 
highlight pythonFunction     guifg=#2b83db
highlight pythonClass        guifg=#2b83db

" Cyan (calls & decorators) 
highlight pythonDecorator    guifg=#22eeee 
highlight pythonDottedName   guifg=#22eeee
highlight pythonFunctionCall guifg=#22eeee

" Yellow (numbers) 
highlight pythonFloat        guifg=#efc402
highlight pythonNumber       guifg=#efc402

" Orange (keywords) 
highlight pythonBoolean      guifg=#c17228
highlight pythonNone         guifg=#c17228
highlight pythonImport       guifg=#c17228
highlight pythonStatement    guifg=#c17228
highlight pythonRepeat       guifg=#c17228
highlight pythonConditional  guifg=#c17228
highlight pythonException    guifg=#c17228
highlight pythonExClass      guifg=#c17228

" Purple (builtins) 
highlight pythonBuiltinType  guifg=#9328c1
highlight pythonBuiltinFunc  guifg=#9328c1
highlight pythonInclude      guifg=#9328c1
highlight pythonBuiltin      guifg=#9328c1
highlight pythonBuiltinObj   guifg=#9328c1
highlight pythonClassVar     guifg=#9328c1



