"██╗░░░██╗██╗███╗░░░███╗██████╗░░█████╗░
"██║░░░██║██║████╗░████║██╔══██╗██╔══██╗
"╚██╗░██╔╝██║██╔████╔██║██████╔╝██║░░╚═╝
"░╚████╔╝░██║██║╚██╔╝██║██╔══██╗██║░░██╗
"░░╚██╔╝░░██║██║░╚═╝░██║██║░░██║╚█████╔╝
"░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝╚═╝░░╚═╝░╚════╝░
" By Drew Herron
" github.com/drewherron/dotfiles.git

""""""""""""
"" Remaps ""
""""""""""""
" Alt puts movement keys in the normal place
" (using Colemak)
" TODO Testing
nnoremap <Esc>h h
nnoremap <Esc>n gj
nnoremap <Esc>e gk
nnoremap <Esc>i l
inoremap <Esc>h <Left>
inoremap <Esc>n <Down>
inoremap <Esc>e <Up>
inoremap <Esc>i <Right>
vnoremap <Esc>h <Left>
vnoremap <Esc>e <Up>
vnoremap <Esc>i <Right>

" Move vertically by visual line
"nnoremap j gj
"nnoremap k gk

" Remap ESC key
"inoremap kj <Esc>

" Remap 0 to first non-blank character
map 0 ^

" Save a keypress in window switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

""""""""""""""""
"" Leader Key ""
""""""""""""""""

" Set leader key
nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"

" Show keybinding index
map <leader>i :help index<cr>

" Fast saving
nmap <leader>w :w!<cr>

" Fast quitting
nmap <leader>q :q<cr>

" Disable search highlight when <leader>Enter is pressed
map <silent> <leader><cr> :noh<cr>


" Sets how many lines of history VIM has to remember
set history=500
" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" :W sudo saves the file
command W w !sudo tee % > /dev/null %

" Number of lines above/below cursor when scrolling
set so=3

" Line numbers relative to cursor
set relativenumber
" but show current line number
set nu rnu

"Always show current position
set ruler

" Turn on the wildmenu
set wildmenu
set wildmode=longest:list,full

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" If you search for caps, stop ignoring case
set smartcase

" Incremental search (while typing)
set incsearch

" Highlight search results
set hlsearch

" Don't redraw while executing macros
set lazyredraw

" Don't require (as many) escapes in search patterns
set magic

" Show matching brackets when text indicator is over them
set showmatch

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add some margin to the left
set foldcolumn=1

" Use spaces instead of tabs
set expandtab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" This caused problems
" set smarttab

" Linebreak on 500 characters
"set lbr
"set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

set foldlevel=10

""""""""""""
"" Colors ""
""""""""""""

" Enable syntax highlighting
syntax enable

" Colorscheme
set notermguicolors


try
    colorscheme aldalome
catch
    colorscheme elflord
endtry

set background=dark

let base16colorspace=256

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Enable 256 colors
set t_Co=256

" This works better in urxvt-256 for some reason
"set t_Co=8

" Hit F3 to see syntax category under cursor
map <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#") . " BG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"bg#")<CR>

let g:lightline = {
    \ 'colorscheme': 'aldalome',
    \ }

"""""""""""
"" Files ""
"""""""""""

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Set a tmp folder for backup files
" All this did was make a new tmp directory in each working directory...
"if !isdirectory("/.vim/tmp")
"    call mkdir("/.vim/tmp", "p")
"endif
"
"set backupdir=~/.vim/tmp//
"set directory=~/.vim/tmp//
"set undodir=~/.vim/tmp//

" Trying this instead
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//

" To disable backups:
"set nobackup
"set nowritebackup
"set noswapfile

""""""""""""""""""""
"" Tabs + Buffers ""
""""""""""""""""""""

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
"map <leader>ba :bufdo bd<cr>

"Switch buffers
"map <leader>? :bnext<cr>
"map <leader>? :bprevious<cr>

" Go to buffer
nnoremap gb :ls<CR>:b<Space>

" Split buffer
map <leader>vs :vs<cr>
map <leader>sp :sp<cr>

" Window split for each buffer (max 6)
map <leader>bs :6sball<cr>

" Create a tab for each buffer
map <leader>bt :tab sball<cr>

" Next tab
map <leader>l :tabn<cr>
map <leader>h :tabp<cr>

" Go to tab number
map <leader>1 :tabnext 1<cr>
map <leader>2 :tabnext 2<cr>
map <leader>3 :tabnext 3<cr>
map <leader>4 :tabnext 4<cr>
map <leader>5 :tabnext 5<cr>
map <leader>6 :tabnext 6<cr>
map <leader>7 :tabnext 7<cr>
map <leader>8 :tabnext 8<cr>
map <leader>9 :tabnext 9<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
" List all tabs
map <leader>t<leader> :tabs
" Close all other tabs
map <leader>to :tabonly<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

set showtabline=1 " Only show tab line if there are at least two tab pages
set noshowmode " Hide the mode text below the statusline

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" Disable automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Show register
map <leader>r :reg<cr>

" Toggle and untoggle spell checking
map <leader>sc :setlocal spell!<cr>

" Remaps deleted - learn the defaults:
" ]s = next bad word
" [s = previous bad word
" zg = add to spellfile
" zw = mark as bad
" z= = show suggestions

" Toggle paste mode on and off
map <leader>p :setlocal paste!<cr>

"""""""""""""""
"" Functions ""
"""""""""""""""

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Stop the cursor from moving backward on leaving insert mode
let CursorColumnI = 0 "the cursor column position in INSERT
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

"""""""""""""
"" Plugins ""
"""""""""""""

" Using vim-plug:
" https://github.com/junegunn/vim-plug
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
"
" Create the directory if absent, and install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Use single quotes in these URLs
" Status line...
Plug 'https://github.com/itchyny/lightline.vim.git'
"...with git
Plug 'https://github.com/itchyny/vim-gitbranch.git'

" File Explorer
Plug 'scrooloose/nerdtree'

" Visual undo tree
Plug 'https://github.com/sjl/gundo.vim.git'

" Colors to hex
Plug 'https://github.com/chrisbra/Colorizer.git'

" Marks in sidebar
Plug 'https://github.com/kshenoy/vim-signature.git'

" Use the next two together for autocomplete
"Plug 'https://github.com/davidhalter/jedi-vim.git'
Plug 'https://github.com/lifepillar/vim-mucomplete.git'

" Improved folding for Python
"Plug 'https://github.com/tmhedberg/SimpylFold.git'

" Initialize plugin system
call plug#end()

" Nerdtree
map <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Colorizer
map <leader>ch :ColorHighlight<CR>

" Gundo
if has('python3')
    let g:gundo_prefer_python3 = 1
endif

nnoremap <leader>u :GundoToggle<CR>

" vim-signature
map <leader>m :SignatureToggle<CR>
" Leaving this here for reference (for now), might make changes
"  mx           Toggle mark 'x' and display it in the leftmost column
"  dmx          Remove mark 'x' where x is a-zA-Z
"
"  m,           Place the next available mark
"  m.           If no mark on line, place the next available mark. Otherwise, remove (first) existing mark.
"  m-           Delete all marks from the current line
"  m<Space>     Delete all marks from the current buffer
"  ]`           Jump to next mark
"  [`           Jump to prev mark
"  ]'           Jump to start of next line containing a mark
"  ['           Jump to start of prev line containing a mark
"  `]           Jump by alphabetical order to next mark
"  `[           Jump by alphabetical order to prev mark
"  ']           Jump by alphabetical order to start of next line having a mark
"  '[           Jump by alphabetical order to start of prev line having a mark
"  m/           Open location list and display marks from current buffer
"
"  m[0-9]       Toggle the corresponding marker !@#$%^&*()
"  m<S-[0-9]>   Remove all markers of the same type
"  ]-           Jump to next line having a marker of the same type
"  [-           Jump to prev line having a marker of the same type
"  ]=           Jump to next line having a marker of any type
"  [=           Jump to prev line having a marker of any type
"  m?           Open location list and display markers from current buffer
"  m<BS>        Remove all markers

""Not really ever using these two
"" Jedi-vim
"autocmd FileType python setlocal completeopt-=preview " Don't open docstring window
"" Keybindings - put here to find/avoid conflicts
"let g:jedi#goto_command = "<leader>g"
"let g:jedi#goto_assignments_command = "<leader>ga"
"let g:jedi#goto_definitions_command = "<leader>gd"
"let g:jedi#documentation_command = "<leader>d"
"let g:jedi#usages_command = "<leader>ju"
"let g:jedi#completions_command = "<C-Space>"
"let g:jedi#rename_command = "<leader>jr"

" Mucomplete
map <leader>a :MUcompleteAutoToggle<CR>
set completeopt+=menuone,noselect
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion
let g:mucomplete#completion_delay = 1 " Set delay
