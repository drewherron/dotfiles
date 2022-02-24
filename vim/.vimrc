""""""""""""
"" Remaps ""
""""""""""""

" Remap ESC key
inoremap kj <Esc>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

" Fast moving
"nnoremap H ^
"nnoremap L $
"nnoremap J <C-d>
"nnoremap K <C-u>

" Smart way to move between windows
"map <C-j> <C-W>j
"map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" For now stealing these two from above for pgup/pgdown
" Consider maybe using to change tabs
map <C-j> <C-d>
map <C-k> <C-u>

" Remap VIM 0 to first non-blank character
map 0 ^

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

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>


" Sets how many lines of history VIM has to remember
set history=500
" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Manjaro conflict?
" :W sudo saves the file
command W w !sudo tee % > /dev/null %

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on hybrid numbers
set relativenumber
set nu rnu

"Always show current position
set ruler

" Turn on the Wild menu
set wildmenu

" First tab completes to longest, seconds tab to open menu
set wildmode=longest:list,full

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Incremental search
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add some margin to the left
set foldcolumn=1


""""""""""""
"" Colors ""
""""""""""""

" Enable syntax highlighting
syntax enable

" Colorscheme
set termguicolors

try
    colorscheme aldalome
catch
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

" To disable backups:
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

" This caused problems
" set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

set foldlevel=10

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

set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" Disable automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

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
map <leader>pp :setlocal paste!<cr>

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
" Only use single quotes in these URLs
" Status line...
Plug 'https://github.com/itchyny/lightline.vim.git'
"...with git
Plug 'https://github.com/itchyny/vim-gitbranch.git'
" Use the next two together for autocomplete
Plug 'https://github.com/davidhalter/jedi-vim.git'
Plug 'https://github.com/lifepillar/vim-mucomplete.git'
" Improved folding for Python
Plug 'https://github.com/tmhedberg/SimpylFold.git'
" File Explorer
Plug 'scrooloose/nerdtree'
" Visual undo tree
Plug 'https://github.com/sjl/gundo.vim.git'
" Colors to hex
Plug 'https://github.com/chrisbra/Colorizer.git'
" Initialize plugin system
call plug#end()

" Nerdtree
map <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Gundo
if has('python3')
    let g:gundo_prefer_python3 = 1
endif

nnoremap <leader>u :GundoToggle<CR>

" Jedi-vim
autocmd FileType python setlocal completeopt-=preview " Don't open docstring window
" Keybindings - put here to find/avoid conflicts
let g:jedi#goto_command = "<leader>g"
let g:jedi#goto_assignments_command = "<leader>ga"
let g:jedi#goto_definitions_command = "<leader>gd"
let g:jedi#documentation_command = "<leader>d"
let g:jedi#usages_command = "<leader>ju"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>jr"

" Mucomplete
map <leader>a :MUcompleteAutoToggle<CR>
set completeopt+=menuone,noselect
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion
let g:mucomplete#completion_delay = 1 " Set delay

" Colorizer
map <leader>ch :ColorHighlight<CR>
