set splitright
set ttimeoutlen=0
set completeopt=menu,menuone,noselect
set expandtab
set shiftwidth=2
set relativenumber
set visualbell    " stop that ANNOYING beeping
set number
set autowrite     " Automatically :write before running commands
set autoread      " Reload files changed outside vim
set pumheight=20
set encoding=utf8

" Autocomplete menu options
set noshowmode
set shortmess+=c

" Trigger autoread when changing buffers or coming back to vim in terminal.
au FocusGained,BufEnter * :silent! !

set backspace=2   " Backspace deletes like most programs in insert mode
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
au BufRead,BufNewFile *.sbt set filetype=scala
set termguicolors

call plug#begin('~/.vim/plugged')
Plug 'akinsho/nvim-bufferline.lua'
Plug 'glepnir/galaxyline.nvim', { 'branch': 'main' } 
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-lint'
Plug 'lvimuser/lsp-inlayhints.nvim'
Plug 'Maan2003/lsp_lines.nvim'
Plug 'stevearc/aerial.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'haydenmeade/neotest-jest'
Plug 'nvim-neotest/neotest-plenary'
Plug 'nvim-neotest/neotest-go'
Plug 'rouge8/neotest-rust'
Plug 'nvim-neotest/neotest-vim-test'
Plug 'nvim-neotest/neotest-python'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do' : 'make' }
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'lukas-reineke/lsp-format.nvim'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'kyazdani42/nvim-tree.lua'
Plug 'EdenEast/nightfox.nvim'
Plug 'projekt0n/github-nvim-theme'
Plug 'karb94/neoscroll.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'github/copilot.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'b0o/SchemaStore.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'folke/lua-dev.nvim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'
Plug 'glepnir/dashboard-nvim'
Plug 'onsails/lspkind-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate' }  " We recommend updating the parsers on update
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'glepnir/lspsaga.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'Equilibris/nx.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'nvim-neotest/neotest'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'David-Kunz/cmp-npm'
Plug 'hrsh7th/nvim-cmp'

Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

Plug 'TimUntersberger/neogit'
Plug 'sindrets/diffview.nvim'
Plug 'rhysd/git-messenger.vim'
Plug 'purescript-contrib/purescript-vim', { 'for': ['purescript', 'purs'] }
Plug 'simrat39/rust-tools.nvim',
Plug 'jose-elias-alvarez/null-ls.nvim',
Plug 'jose-elias-alvarez/typescript.nvim',
call plug#end()

let mapleader = "\<Space>"
lua require 'settings'
  
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

noremap YY "+y<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif
" ************** Key Mappings *******************************************  
inoremap jk <Esc>

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
noremap <silent> Y y$

set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
