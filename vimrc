execute pathogen#infect()
set nocompatible            " Use Vim defaults
filetype off                " required for vundle, can be turned on later

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree.git'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic.git'
if has('python')
    Bundle 'davidhalter/jedi-vim.git'
endif
Bundle 'nvie/vim-flake8'
Bundle 'flazz/vim-colorschemes'
Bundle 'jmcantrell/vim-virtualenv'
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'Quramy/tsuquyomi'

call vundle#end()

let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args = "--max-line-length=85"
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint']
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1


au BufReadPost *.conf set syntax=ini

" Open NERDTree by default if no fils are specified
autocmd vimenter * if !argc() | NERDTree | endif
let g:NERDTreeDirArrows=0
let NERDTreeIgnore = ['\.pyc$']

let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

if exists("g:colors_name")
    if g:colors_name != 'solarized'
        " I despise bright yellow line numbers
        " disabled for solarized
        highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
    endif
endif


" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>


syntax on
set autoindent                              " Copy indent from last line when starting new line
set background=dark                         " Dark background
set synmaxcol=2048                          " Prevent slow downs from syntax highlighting
"set cindent
set shiftwidth=4                            " The number of spaces for indenting
"set tabstop=4
set expandtab                               " Expand tabs to spaces
set softtabstop=4                           " Tab key results in 2 spaces
set shiftround                              " Indent/outdent to nearest tabstops
set tabpagemax=50                           " Allow way more tabs
set hidden                                  " When a buffer is brought to foreground, remember undo history and marks
set ic                                      " Ignore case in search (ignorecase)
set incsearch                               " Incremental search - highlights dynamically as pattern is typed
set hlsearch                                " Highlight search results
set smartcase                               " Ignore case when lowercase
set scrolloff=8                             " Always have some lines of text when scrolling
set laststatus=2                            " Always show status line
set bs=indent,eol,start                     " Allow backspacing over everything in insert mode
set viminfo=%,'9999,s512,n~/.vim/viminfo    " Restore buffer list, marks are remembered for 9999 files, registers up to 512Kb are remembered
set history=50                              " Keep 50 lines of command line history
set ruler                                   " Show the cursor position all the time
set number                                  " Linenumbers
set nostartofline                           " Don't reset cursor to start of line when moving around.
set showmode                                " Show the current mode
set title                                   " Show the filename in the window titlebar
set splitbelow                              " New window goes below
set splitright                              " New windows goes right
" set noerrorbells                          " Disable error bells
" set visualbell                            " Use visual bell instead of audible bell (annnnnoying)
" set nowrap                                " Do not wrap lines
" set gdefault                              " By default add g flag to search/replace. Add g to toggle
" set cursorline                            " Highlight current line
" set undofile                              " Persistent Undo

filetype on                                 " Enable filetype detection
filetype indent on                          " Enable filetype-specific indenting
filetype plugin on                          " Enable filetype-specific plugins

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif

" Better split switching (Ctrl-j, Ctrl-k, Ctrl-h, Ctrl-l)
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

cmap w!! w !sudo tee > /dev/null %
