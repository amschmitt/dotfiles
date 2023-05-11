""""""""""""""""""""""""""""""""
" VIMRC
""""""""""""""""""""""""""""""""
set nocompatible

""""""""""""""""""""""""""""""""
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
Plug 'github/copilot.vim'

" language packs
Plug 'hashivim/vim-terraform'
Plug 'iamcco/markdown-preview', { 'do': 'cd app && yarn install' }

" Vimwiki
Plug 'vimwiki/vimwiki'

" Vim functionality
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter' " comment lines out
Plug 'jiangmiao/auto-pairs' " automatically create closing braces/brackets etc.

" Trial plugins

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'dense-analysis/ale'

Plug 'webastien/vim-ctags' " ctags
Plug 'preservim/tagbar' " 'structure' view for tags

Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

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

" yanking/pasting should work from windows clipboard
set clipboard+=unnamed
" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif


""""""""""""""""""""""""""""""""
" General Key Mappings
""""""""""""""""""""""""""""""""

" leader is comma
let mapleader=","

" really cool find/replace behavior
"  local replace for normal languages with braces defining scoping
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>
"  local replace for python, scoped to functions (not inner scopes like if/for)
nnoremap <space>p gd[[V]]::s/<C-R>///gc<left><left><left>
"  global replace
nnoremap gR gD:s/<C-R>///gc<left><left><left>

""""""""""""""""""""""""""""""""
" ctags
""""""""""""""""""""""""""""""""
map <silent> <space>j :call DisplayTag()<CR>
map <silent> <space>k :call DisplayGivenTag()<CR>
nnoremap <silent> <space>r :call RebuildTags()<CR>

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
" ALE
""""""""""""""""""""""""""""""""

" enable ALE to autofix on file save
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_linters = {
\   'python': ['pylint', 'mypy']
\}

let g:ale_fixers = {
\   '*': ['trim_whitespace'],
\   'python': ['black'],
\   'terraform': ['terraform'],
\   'json': ['fixjson']
\}

" enable autocompletion where available
let g:ale_completion_enabled = 1

" for python, disable ALE's autodetection of virtual envs, which is based
" on the current directory somehow. This config will force ALE to use the
" env var $VIRTUAL_ENV
let g:ale_virtualenv_dir_names = []

""""""""""""""""""""""""""""""""
" Python VirtualEnv
""""""""""""""""""""""""""""""""

" point VIM to global Python executable
" or, try to use $VIRTUAL_ENV?
let g:python3_host_prog="$VIRTUAL_ENV/bin/python3"

""""""""""""""""""""""""""""""""""
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
filetype plugin indent on

" modern backspace behavior
set backspace=indent,eol,start

" no \r
set fileformat=unix

""""""""""""""""""""""""""""""""
" Cursor
""""""""""""""""""""""""""""""""

let &t_SI = "\<esc>[6 q"  " blinking I-beam in insert mode
let &t_SR = "\<esc>[4 q"  " blinking underline in replace mode
let &t_EI = "\<esc>[2 q"  " default cursor (usually blinking block) otherwise

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
