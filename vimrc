
" Plugins
""""""""""""""""""""""""""""""""

" this is supposed to automatically download/install plug.vim

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Visual/aesthetic

Plug 'vim-airline/vim-airline'
Plug 'chriskempson/base16-vim'

" Symlink following for VIM
Plug 'moll/vim-bbye'
Plug 'aymericbeaumet/vim-symlink'

" nerdtree
Plug 'scrooloose/nerdtree'

" git

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Vimwiki

Plug 'vimwiki/vimwiki'

call plug#end()

""""""""""""""""""""""""""""""""
" General Configuration
""""""""""""""""""""""""""""""""

" automatically update a file if it is changed externally
set autoread

" command bar height
set cmdheight=2

" show line numbers
set number

" search ignores case by default
set ignorecase

" show last command in bottom-right
set showcmd


""""""""""""""""""""""""""""""""
" General Key Mappings
""""""""""""""""""""""""""""""""

" leader is comma
let mapleader=","


""""""""""""""""""""""""""""""""
" Colors and Fonts
""""""""""""""""""""""""""""""""

" syntax hignlighting
syntax on

" UTF-8 encoding
set encoding=utf8

" highlight cursor active line
set cursorline
highlight CursorLine ctermbg=black

let base16colorspace=256
colorscheme base16-twilight
set background=dark

""""""""""""""""""""""""""""""""
" Text and Indentation
""""""""""""""""""""""""""""""""

" smart tabs
set smarttab

" use spaces, never tabs
set expandtab

" 1 tab is 4 spaces
set shiftwidth=4
set softtabstop=4

" auto-indent and smart-indent
set ai
set si

" enable filetype-specific indentation
filetype indent on

" modern backspace behavior
set backspace=indent,eol,start


""""""""""""""""""""""""""""""""
" vimwiki
""""""""""""""""""""""""""""""""

let g:vimwiki_list = [{'path': '~/vimwiki/', 'auto_export': 1}]

""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""

let NERDTreeShowHidden=1

" open/close NERDTree using Leader-f (,-f)
nnoremap <Leader>f :NERDTreeToggle<Enter>
