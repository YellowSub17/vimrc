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
    Plug 'ycm-core/YouCompleteMe' 
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

" Numbers and UI 
set number 
set relativenumber 
set scrolloff=8 
set colorcolumn=80 

" Tabs and Search 
set expandtab 
set shiftwidth=4 
set tabstop=4 
set smartcase 
set incsearch 

" =============================================================================
" 4. MAPPINGS & LOGIC 
" =============================================================================
nmap <S-Left> b
nmap <S-Right> w
nmap <leader>[ :bp!<CR>
nmap <leader>] :bn!<CR>

for i in range(1, 9)
    exe 'nmap <Leader>'.i.' <Plug>lightline#bufferline#go('.i.')'
    "exe 'nmap <Leader>qb'.i.' <Plug>lightline#bufferline#delete('.i.')'
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


"" Enable system clipboard integration
"set clipboard=unnamedplus

"" Ctrl+C to copy in Visual Mode
vnoremap <leader>copytext "+y

"" Ctrl+V to paste in Normal and Insert Mode
nnoremap <leader>pastetext "+p
"inoremap <C-v> <C-r>+

" =============================================================================
" 5. APPEARANCE & LIGHTLINE
" =============================================================================
colorscheme evening 
highlight Normal       guifg=#cfcfcf guibg=#1d1d1d
highlight LineNr       guifg=#999999 guibg=#1d1d1d
highlight ColorColumn  guibg=#333333 
highlight EndOfBuffer  guifg=#ffffff guibg=#1d1d1d

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





