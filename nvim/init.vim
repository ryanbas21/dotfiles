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

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'sbdchd/neoformat'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do' : 'make' }
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'kyazdani42/nvim-tree.lua'
Plug 'EdenEast/nightfox.nvim'
Plug 'projekt0n/github-nvim-theme'
Plug 'karb94/neoscroll.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'github/copilot.vim'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'b0o/SchemaStore.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'elm-tooling/elm-vim' , { 'for': 'elm' }
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
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'williamboman/nvim-lsp-installer'

Plug 'janko/vim-test'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'rcarriga/nvim-dap-ui'
Plug 'rcarriga/neotest'
Plug 'rcarriga/neotest-vim-test'
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }

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
  
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html Neoformat prettier

function! s:setup_git_messenger_popup() abort
    nmap <buffer><C-o> o
    nmap <buffer><C-i> O
endfunction

let g:dashboard_default_executive = 'telescope'
let g:dashboard_custom_header = [
    \'',
     \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣤⣴⣦⣤⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
     \'⠀⠀⠀⠀⠀⠀⢀⣤⣾⣿⣿⣿⣿⠿⠿⠿⠿⣿⣿⣿⣿⣶⣤⡀⠀⠀⠀⠀⠀⠀ ',
     \'⠀⠀⠀⠀⣠⣾⣿⣿⡿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⢿⣿⣿⣶⡀⠀⠀⠀⠀ ',
     \'⠀⠀⠀⣴⣿⣿⠟⠁⠀⠀⠀⣶⣶⣶⣶⡆⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣦⠀⠀⠀ ',
     \'⠀⠀⣼⣿⣿⠋⠀⠀⠀⠀⠀⠛⠛⢻⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣧⠀⠀ ',
     \'⠀⢸⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⡇⠀ ',
     \'⠀⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⠀ ',
     \'⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⡟⢹⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⣹⣿⣿⠀ ',
     \'⠀⣿⣿⣷⠀⠀⠀⠀⠀⠀⣰⣿⣿⠏⠀⠀⢻⣿⣿⡄⠀⠀⠀⠀⠀⠀⣿⣿⡿⠀ ',
     \'⠀⢸⣿⣿⡆⠀⠀⠀⠀⣴⣿⡿⠃⠀⠀⠀⠈⢿⣿⣷⣤⣤⡆⠀⠀⣰⣿⣿⠇⠀ ',
     \'⠀⠀⢻⣿⣿⣄⠀⠀⠾⠿⠿⠁⠀⠀⠀⠀⠀⠘⣿⣿⡿⠿⠛⠀⣰⣿⣿⡟⠀⠀ ',
     \'⠀⠀⠀⠻⣿⣿⣧⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⠏⠀⠀⠀ ',
     \'⠀⠀⠀⠀⠈⠻⣿⣿⣷⣤⣄⡀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⠟⠁⠀⠀⠀⠀ ',
     \'⠀⠀⠀⠀⠀⠀⠈⠛⠿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⠁⠀⠀⠀⠀⠀⠀ ',
     \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠛⠛⠛⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
     \]

let g:indentLine_fileTypeExclude = ['dashboard']

autocmd FileType gitmessengerpopup call <SID>setup_git_messenger_popup()
let g:git_messenger_floating_win_opts = { 'border': 'single' }
let g:git_messenger_popup_content_margins = v:false


let test#python#pytest#options = "--color=yes"
let test#javascript#jest#options = "--color=always"

augroup UltestRunner
    au!
    au BufWritePost * UltestNearest
augroup END

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

nmap ,, <C-^>

" create a new file
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Remove that dumb search highlight
nmap <silent> <leader>, :nohl<cr>

"escaping
inoremap jk <Esc>

nmap <Leader>gs :Neogit<CR>
nnoremap <silent> <Leader>f <cmd>Telescope file_browser<CR>
nnoremap <silent> <Leader>b <cmd>Telescope buffers<CR>
nnoremap <silent> <Leader><Leader> <cmd>Telescope git_files<CR>
nnoremap <silent> <leader>; <cmd>Telescope current_buffer_fuzzy_find<CR>
nnoremap <leader>S <cmd>Telescope grep_string<CR> 
nnoremap <leader>s <cmd>Telescope live_grep<CR>

nnoremap <C-n> :NvimTreeToggle<CR>

" ***************************************
"
" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
noremap <silent> Y y$

set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

nnoremap <silent>[b :BufferLineCycleNext<CR>
nnoremap <silent>]b :BufferLineCyclePrev<CR>
