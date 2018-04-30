set nocompatible
set guifont=Inconsolata\ for\ Powerline:h15
filetype plugin indent on
scriptencoding utf-8
set encoding=utf-8
set termguicolors
set smartindent
set showmatch
set relativenumber
set textwidth=80
set formatoptions=qrn1
set wrapmargin=0
set colorcolumn=+1
set autoindent
set wrapmargin=0
set colorcolumn=+1
set lines=50 columns=100
set number
set tabstop=2
set shiftwidth=2
set expandtab
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
set t_Co=256

set exrc
set secure

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim

" Make Searching Beter

set gdefault
set ignorecase

" Stop highlight after searching
set hlsearch
nnoremap <silent> <leader>, :noh<cr>

" Allow mouse in iterm
"Allow usage of mouse in iTerm
set ttyfast
set mouse=a

set cursorline    " highlight the current line
set visualbell    " stop that ANNOYING beeping

set autowrite     " Automatically :write before running commands
set autoread      " Reload files changed outside vim
"
" Trigger autoread when changing buffers or coming back to vim in terminal.
au FocusGained,BufEnter * :silent! !

set backspace=2   " Backspace deletes like most programs in insert mode

set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287

set ruler         " show the cursor position all the time

let g:Powerline_symbols = 'fancy'
" Configure Cursor shape based on mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
let mapleader = "\<Space>"

autocmd FileType typescript: set makeprg=tsc
augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown


let g:monokai_gui_italic = 1

filetype off
if has("gui_running")
   let s:uname = system("uname")
   if s:uname == "Darwin\n"
     set guifont=Meslo\ LG\ S\ for\ Powerline
   endif
 endif

 if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Color / Themes
Plug 'rafi/awesome-vim-colorschemes'
Plug 'viniciusban/vim-ubuntu-colorscheme'
Plug 'junegunn/limelight.vim', { 'on': 'GoyoEnter' }

" TMUX
Plug 'benmills/vimux'

" Git
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'

" Movement
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'junegunn/goyo.vim', { 'on': 'GoyoEnter' }

" Syntax
Plug 'crusoexia/vim-javascript-lib'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx', { 'for' : ['javascript', 'typescript' ] }
Plug 'Quramy/tsuquyomi'
Plug 'prettier/prettier-eslint-cli', { 'for': ['javascript', 'typescript'] }
Plug 'leafgarland/typescript-vim', { 'for' : 'typescript' }
Plug 'mitermayer/vim-prettier', {
	\ 'do': 'yarn install',
	\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss'] }

Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }

" Completion
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'w0rp/ale'

" File Tree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Searching
Plug 'shougo/vimproc.vim', {'do' : 'make'}
Plug 'tpope/vim-commentary'
Plug 'wakatime/vim-wakatime'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'ternjs/tern_for_vim'


call plug#end()

filetype plugin indent on    " required
colorscheme space-vim-dark 
hi Comment cterm=italic

" Easy Motion
map <Leader> <Plug>(easymotion-prefix)

" Easy Align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

let g:CommandTAcceptSelectionMap = '<C-t>'
let g:CommandTAcceptSelectionTabMap = '<CR>'

" NERDTREE
let g:NERDTreeShowHidden=1

"vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

"vim-jsx
let g:jsx_ext_required = 0

" ALE Setup
 let g:ale_emit_conflict_warnings = 1
 let g:airline#extensions#ale#enabled = 1
 let g:ale_sign_warning = '--'
 let g:ale_sign_errorle_echo_msg_error_str = 'E'
 let g:ale_echo_msg_warning_str = 'W'
 let g:ale_lint_on_text_changed = 'never'
 let g:ale_linters = { 'javascript': ['prettier'], 'typescript' : ['prettier'] }

" Airline
 let g:airline#extensions#tabline#enabled = 1
 let g:airline#extensions#tabline#left_sep = ' '
 let g:airline#extensions#tabline#left_alt_sep = '|'
 let g:airline_theme='gruvbox'

" NERDTREE
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" YCM gives you popups and splits by default that some people might not like, so these should tidy it up a bit for you.
let g:ycm_confirm_extra_conf=1
" set completeopt-=preview
autocmd FileType javascript setlocal omnifunc=tern#Complete
if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window (for an alternative on Windows, see simalt below).
  set lines=999 columns=999
else
  " This is console Vim.
  if exists("+lines")
    set lines=50
  endif
  if exists("+columns")
    set columns=100
  endif
endif
if !exists("g:ycm_semantic_triggers")
 let g:ycm_semantic_triggers = {}
 endif
 let g:ycm_semantic_triggers['typescript'] = ['.']

 " Typescript
let g:typescript_opfirst='\%([<>=,?^%|*/&]\|\([-:+]\)\1\@!\|!=\|in\%(stanceof\)\=\>\)'
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
autocmd FileType typescript :set makeprg=tsc
autocmd FileType typescript setl omnifunc=tsuquyomi#complete

" Prettier setup
" For Work!
let g:prettier#autoformat = 1
autocmd FileType javascript set formatprg=prettier-eslint
autocmd FileType typescript set formatprg=prettier-tslint
let g:prettier#config#print_width = 120
let g:prettier#config#tab_width = 4
let g:prettier#config#use_tabs = 'true'
let g:prettier#config#semi = 'true'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'true'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#single_quote='true'
let g:prettier#config#parser = 'typescript'
let g:prettier#config#config_precedence = 'prefer-file'
autocmd BufWritePre *.js,*.json,*.css,*ts,*.scss,*.less,*.graphql PrettierAsync
"
"KEY MAPPINGS
" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
nmap <C-n> :NERDTreeToggle<CR>

" Remap To Normal Mode
inoremap jj <esc>
inoremap jk <esc>

  "" Fugitive
  au FileType gitcommit setlocal completefunc=emoji#complete
  au FileType gitcommit nnoremap <buffer> <silent> cd :<C-U>Gcommit --amend --date="$(date)"<CR>

  fun! FzfOmniFiles()
	 let is_git = system('git status')
	 if v:shell_error
		 :Files
	else
		:GFiles --exclude-standard -o
	endif
endfun

" FZF Config
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'down': '~40%' }
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_files_options = "--preview '[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null | head -500'"
  

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

" Hide statusline of terminal buffer
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
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
  \ 'header':  ['fg', 'Comment'] }

  " File types
  au BufNewFile,BufRead *.js               set filetype=javascript
  au BufNewFile,BufRead *.jsx 		   set filetype=javascript
  au BufNewFile,BufRead *.ts               set filetype=typescript
  au BufNewFile,BufRead *.tsx              set filetype=typescript
  au BufNewFile,BufRead *.hs		   set filetype=haskell


  function! s:goyo_enter()
  if has('gui_running')
    set fullscreen
    set background=light
    set linespace=7
  elseif exists('$TMUX')
    silent !tmux set status off
  endif
  Limelight
  let &l:statusline = '%M'
  hi StatusLine ctermfg=red guifg=red cterm=NONE gui=NONE
endfunction

function! s:goyo_leave()
  if has('gui_running')
    set nofullscreen
    set background=dark
    set linespace=0
  elseif exists('$TMUX')
    silent !tmux set status on
  endif
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

nnoremap <Leader>G :Goyo<CR>

let g:ackprg = 'rg --vimgrep --no-heading'

" KEY MAPPINGS
map <LEADER>a :Ack!<Space>
nmap <Leader>F :Files<CR>
nmap <Leader>B :Buffers<CR>


map <Leader>rt :call VimuxRunCommand("clear; npm run transpile; npm t" )<CR>

  " Automatically wrap at 100 characters and spell check git commit messages
autocmd FileType gitcommit setlocal textwidth=100
autocmd FileType gitcommit setlocal spell

" Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  "CTAGS
let g:easytags_async = 1
syntax on
