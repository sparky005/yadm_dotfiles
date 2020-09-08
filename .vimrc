" basic configuration settings
" a lot of these get set with vim-sensible
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

" esc should exit terminal mode
tnoremap <Esc> <C-\><C-n>

" install vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'ctrlpvim/ctrlp.vim'
" an alternative to ctrlp is fzf, worth considering if i ever get sick of
" ctrlp
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
" fallback for any other syntaxes i may not use frequently
Plug 'sheerun/vim-polyglot'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'hashivim/vim-terraform'
call plug#end()

" deoplete
let g:deoplete#enable_at_startup = 1
set splitbelow " move preview pane to bottom
" sets python3_host_prog to virtualenv specifically for nvim
" this virtualenv should have been created by yadm bootstrap
let g:python3_host_prog = system('cd ~/nvim_env; echo -n $(poetry env info -p)/bin/python')
" change deoplete key to tab
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" hide panel when done inserting
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif


" show docs for jedi and ternjs
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#jedi#show_docstring = 1

" terraform config
let g:terraform_align=1
let g:terraform_fmt_on_save=1
