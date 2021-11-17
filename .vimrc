" basic configuration settings
" a lot of these get set with vim-sensible
filetype plugin indent on " default in nvim
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
" let's try fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
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
" Improved motion in Vim
Plug 'easymotion/vim-easymotion'
" better buffer management with leader-b
Plug 'jeetsukumaran/vim-buffergator'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'ruanyl/vim-gh-line'
Plug 'tsandall/vim-rego'
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
" fix for https://github.com/carlitux/deoplete-ternjs/issues/88
call deoplete#custom#option('num_processes', 4)


" show docs for jedi and ternjs
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#jedi#show_docstring = 1

" terraform config
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" buffergator
let g:buffergator_viewport_split_policy = "B"
let g:buffergator_hsplit_size = 5
let g:buffergator_autodismiss_on_select = 0
let g:buffergator_autoupdate = 1

" vim-gh-line
let g:gh_open_command = 'fn() { echo "$@" | pbcopy; }; fn '

let g:ctrlp_max_files=0 " no limit
let g:ctrlp_clear_cache_on_exit = 0 " keep cache between runs
" use ripgrep for ctrlp
if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif
