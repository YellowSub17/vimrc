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
set scrolloff=16

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
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif


call plug#begin()

    " color utils
    Plug 'max397574/colortils'

    Plug 'nvim-lualine/lualine.nvim'
    " If you want to have icons in your statusline choose one of these
    Plug 'nvim-tree/nvim-web-devicons'

    " better status line
    Plug 'itchyny/lightline.vim'
    " bufferline
    Plug 'mengelbrecht/lightline-bufferline'


    " commenting
    Plug 'preservim/nerdcommenter'

    ""Highlight yanked text
    Plug 'machakann/vim-highlightedyank'

    "file tree
    Plug 'preservim/nerdtree' 

    Plug 'neoclide/coc.nvim', {'branch': 'release'}


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
highlight pythonBuiltind guifg=#9328c1 guibg=#1d1d1d ctermfg=magenta ctermbg=black 
highlight pythonBuiltinObj guifg=#9328c1 guibg=#1d1d1d ctermfg=magenta ctermbg=black 
highlight pythonClassVar guifg=#9328c1 guibg=#1d1d1d ctermfg=magenta ctermbg=black 
highlight pythonBytesEscape guifg=#88dd88 guibg=#1d1d1d ctermfg=green ctermbg=black 
highlight pythonStrFormat guifg=#88dd88 guibg=#1d1d1d ctermfg=green ctermbg=black 



""___________________
""___________________
"" COC settings
""___________________
""___________________

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

