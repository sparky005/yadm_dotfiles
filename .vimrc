" basic configuration settings
set nocompatible " Improved
filetype plugin indent on
set hidden "allow hidden buffers
set autoread
" syntax highlighting
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set number
set softtabstop=4
colorscheme elflord
"colorscheme mellow-contrast

" let ctrl+l leave insert mode
imap <C-L> <Esc>

" easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" install vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
" fallback for any other syntaxes i may not use frequently
Plug 'sheerun/vim-polyglot'
call plug#end()
