if &compatible
  set nocompatible               " Be iMproved
endif

augroup MyAutoCmd
  autocmd!
augroup END
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim
let s:dein_dir = expand($HOME . '/.cache/dein')
let s:toml_dir = expand($HOME . '/.config/nvim')

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml = s:toml_dir . '/dein.toml'
  let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call map(dein#check_clean(), "delete(v:val, 'rf')")
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif


"色の設定
set termguicolors

"UIまわり
set cmdheight=2
set number
set norelativenumber
set cursorline
set lazyredraw
set sidescrolloff=16
set scrolloff=18
set mouse=a
set laststatus=2
set completeopt-=preview

"システム周り？
set nowritebackup
set nobackup
set noswapfile
set autoread
set encoding=utf-8
set vb t_vb=
set confirm
set hidden
set undofile
set wildmenu
set clipboard+=unnamedplus
"なんかあれ
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set smartindent
set showmatch matchtime=1
set backspace=start,eol,indent
set virtualedit+=block
set conceallevel=0

"検索だけど
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrap


