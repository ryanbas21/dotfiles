scriptencoding utf-8
set ttimeout
set ttimeoutlen=0
set splitright
set smartindent
set showmatch
set encoding=utf8
set relativenumber
set textwidth=80
set formatoptions=qrn1
set autoindent
set wrapmargin=0
set cc=0
set number
set tabstop=2
set shiftwidth=2
set expandtab
set termencoding=utf-8
set exrc
set secure
" Make Searching Beter
set gdefault
set ignorecase
" Stop highlight after searching
set hlsearch
set cursorline    " highlight the current line
set visualbell    " stop that ANNOYING beeping
set autowrite     " Automatically :write before running commands
set autoread      " Reload files changed outside vim

" Trigger autoread when changing buffers or coming back to vim in terminal.
au FocusGained,BufEnter * :silent! !

set backspace=2   " Backspace deletes like most programs in insert mode
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set ruler         " show the cursor position all the time

" Configure Cursor shape based on mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

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
Plug 'chriskempson/base16-vim'
Plug 'wadackel/vim-dogrun'
Plug 'janko/vim-test'
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }
Plug 'akinsho/nvim-bufferline.lua'
Plug 'itchyny/lightline.vim'  " status line
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
Plug 'chemzqm/vim-jsx-improve'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle'} " file tree
Plug 'psliwka/vim-smoothie' " smooth scrolling
Plug 'tpope/vim-fugitive' " Git 
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat' " Make dot command better
Plug 'tpope/vim-surround' " quotes/blocks/tags and more manipulation
Plug 'tpope/vim-commentary' " comment out stuff
Plug 'tpope/vim-projectionist' " switch between test files or create them
Plug 'tpope/vim-unimpaired' 
Plug 'tpope/vim-eunuch' " Added Unix command capability for vim
Plug 'neovimhaskell/haskell-vim' , { 'for': 'haskell' }
Plug 'elm-tooling/elm-vim' , { 'for': 'elm' }
Plug 'andys8/vim-elm-syntax' , { 'for': 'elm' }
Plug 'rafi/awesome-vim-colorschemes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

call plug#end()

let test#python#pytest#options = "--color=yes"
let test#javascript#jest#options = "--color=always"

nmap ]t <Plug>(ultest-next-fail)
nmap [t <Plug>(ultest-prev-fail)

augroup UltestRunner
    au!
    au BufWritePost * UltestNearest
augroup END
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" Customize fzf colors to match your color scheme
let g:fzf_colors = { 
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] 
  \ }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Override Colors command. You can safely do this in your .vimrc as fzf.vim
" will not override existing commands.
command! -bang Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('down:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

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

"Jest 
nnoremap <c-t>c :call CocAction('runCommand', 'jest.fileTest', ['%'])<CR>
nmap ,, <C-^>

let mapleader = "\<Space>"

" create a new file
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" Remove that dumb search highlight
nmap <silent> <leader>, :nohl<cr>
"escaping
inoremap jk <Esc>

" git 
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gb :Gblame<CR>
nmap <Leader>gp :Gpush origin<space>

" ************Coc******************

autocmd FileType python let b:coc_root_patterns = ['.git', '.env']
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

nmap <leader>d :CocList diagnostics<CR>
nmap <leader>l :CocList
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader><Leader> :GFiles<CR>
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <Leader>s :GGrep<space>
nnoremap <Leader>S :Rg <space><C-r><C-w><CR>
nnoremap <leader>y :CocList -N  --ignore-case yank<CR>
nnoremap <leader>h :History: <CR>
nnoremap <leader>p :CocList mru <CR>
nnoremap <leader>c :History/ <CR>
nnoremap <leader>a :CocList -N  --ignore-case actions<CR>
nnoremap <leader>m :CocList marks<CR>
nnoremap <C-p> :CocList mru<CR>

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" Use tab and shift tab to navigate completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Use Enter for coc completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition) 
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>A   <Plug>(coc-codelens-action)
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>l :CocList<space>
nmap <leader>d :CocList diagnostics<CR>

command! -nargs=0 Tsc :call CocAction('runCommand', 'tsserver.watchBuild')

inoremap <silent><expr> <c-space> coc#refresh()

" ***************************************
" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

function! LightlineObsession()
    return '%{ObsessionStatus()}'
endfunction

noremap <silent> Y y$
"*************** LightLine ***********************
  let g:lightline = {
      \ 'colorscheme': 'dogrun',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ ['percent', 'lineinfo'], [ 'fileformat', 'fileencoding', 'filetype', 'filesize' ],['obsession']],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status',
      \ },
      \ 'component_expand': {
      \   'obsession': 'LightlineObsession',
      \   'fzf': 'FzfStatusLine'
      \}
      \ }
"*************************************************

" let g:fugitive_github_domains = ['github.homeawaycorp.com']

" **************** GIT ********************

" Automatically wrap at 100 characters and spell check git commit messages
augroup Git
  autocmd!
  autocmd FileType gitcommit setlocal textwidth=120
  autocmd FileType gitcommit setlocal spell
augroup end

" ************************************************


"NerdTree
map <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

" ****************** Projectionist *************
let g:projectionist_heuristics = {
      \   '*': {
      \     '*.c': {
      \       'alternate': '{}.h',
      \       'type': 'source'
      \     },
      \     '*.h': {
      \       'alternate': '{}.c',
      \       'type': 'header'
      \     },
      \
      \     '*.tsx': {
      \       'alternate': [
      \         '{dirname}/{basename}.test.tsx',
      \         '{dirname}/__tests__/{basename}-test.tsx'
      \       ],
      \       'type': 'source'
      \     },
      \     '*.test.tsx': {
      \       'alternate': '{basename}.tsx',
      \       'type': 'test',
      \     },
      \     '*.ts': {
      \       'alternate': [
      \         '{dirname}/{basename}.test.ts',
      \         '{dirname}/__tests__/{basename}-test.ts'
      \       ],
      \       'type': 'source'
      \     },
      \     '*.test.ts': {
      \       'alternate': '{basename}.ts',
      \       'type': 'test',
      \     },
      \     '**/__tests__/*-test.ts': {
      \       'alternate': '{dirname}/{basename}.ts',
      \       'type': 'test'
      \     },
      \
      \     '*.js': {
      \       'alternate': [
      \         '{dirname}/{basename}.test.js',
      \         '{dirname}/__tests__/{basename}.spec.js',
      \       ],
      \       'type': 'source'
      \     },
      \     '*.test.js': {
      \       'alternate': '{basename}.js',
      \       'type': 'test',
      \     },
      \     '*.spec.js': {
      \       'alternate': '{basename}.js',
      \       'type': 'test',
      \     },
      \     '**/__tests__/*-mocha.js': {
      \       'alternate': '{dirname}/{basename}.js',
      \       'type': 'test'
      \     },
      \     '**/__tests__/*-test.js': {
      \       'alternate': '{dirname}/{basename}.js',
      \       'type': 'test'
      \     },
      \
      \     'src/*.re': {
      \       'alternate': [
      \         '__tests__/{}_test.re',
      \         'src/{}_test.re',
      \         'src/{}.rei'
      \       ],
      \       'type': 'source'
      \     },
      \     'src/*.rei': {
      \       'alternate': [
      \         'src/{}.re',
      \         '__tests__/{}_test.re',
      \         'src/{}_test.re',
      \       ],
      \       'type': 'header'
      \     },
      \     '__tests__/*_test.re': {
      \       'alternate': [
      \         'src/{}.rei',
      \         'src/{}.re',
      \       ],
      \       'type': 'test'
      \     }
      \   }
      \ }

syntax on
colorscheme base16-onedark
