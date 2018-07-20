set nocompatible
set guifont=Inconsolata\ for\ Powerline:h16

filetype plugin indent on
scriptencoding utf-8

set encoding=utf-8
set smartindent
set showmatch
set relativenumber
set textwidth=80
set formatoptions=qrn1
set wrapmargin=0
set autoindent
set wrapmargin=0
set colorcolumn=+1
set number
set tabstop=2
set shiftwidth=2
set expandtab
set fillchars+=stl:\ ,stlnc:\
set termencoding=utf-8
set exrc
set secure

set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim

" Make Searching Beter
set gdefault
set ignorecase

 " ctags optimization
set autochdir
set tags=tags;

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

let g:Powerline_symbols = 'fancy'

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

" Set syntax highlighting for specific file types
autocmd BufRead,BufNewFile *.md set filetype=markdown

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set termguicolors

" ******** PLUGINS ***********8

call plug#begin('~/.vim/plugged')

" Color / Themes
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'

" TMUX
Plug 'parsonsmatt/intero-neovim', { 'for': ['haskell'] }

" Git
Plug 'tpope/vim-fugitive'

" Movement
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'ludovicchabant/vim-gutentags'

" Syntax
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx', { 'for' : ['javascript', 'typescript' ] }
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
Plug 'Quramy/tsuquyomi', { 'for' : ['typescript'] }
Plug 'leafgarland/typescript-vim', { 'for' : ['typescript'] }

" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'HerringtonDarkholme/yats.vim'
" For async completion
Plug 'Shougo/deoplete.nvim'
" For Denite features
Plug 'Shougo/denite.nvim'

Plug 'w0rp/ale'

" File Tree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Searching
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'

call plug#end()
" ************ TYPESCRIPT ******
 " Typescript
let g:typescript_opfirst='\%([<>=,?^%|*/&]\|\([-:+]\)\1\@!\|!=\|in\%(stanceof\)\=\>\)'
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
" ********************************
" ****************************


" ***************** DEOPLETE *****************
let g:deoplete#enable_at_startup = 1
"  **************************** 

" ******************Easy Motion *********************
map <Leader> <Plug>(easymotion-prefix)
" ***************************************************

"v******************vim-javascript******************
"
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
"******************************************************

" ************************************vim-jsx******************
let g:jsx_ext_required = 0
" ******************************************************

" ************************ALE Setup******************************
 let g:ale_emit_conflict_warnings = 1
 let g:airline#extensions#ale#enabled = 1
 let g:ale_sign_warning = '--'
 let g:ale_sign_errorle_echo_msg_error_str = 'E'
 let g:ale_echo_msg_warning_str = 'W'
 let g:ale_lint_on_text_changed = 'never'
 let g:ale_fix_on_save = 1
 let g:ale_fixers = { 'css': ['prettier'], 'javascript': ['prettier'], 'typescript' : ['prettier'] }
 let g:ale_linters = { 'javascript': ['prettier'], 'typescript' : ['prettier'], 'haskell': ['stack-ghc', 'ghc-mod', 'hlint', 'hdevtools', 'hfmt'] }
" ************************************************************


" ********************* NERDTREE ************************************ 
let g:NERDTreeIndicatorMapCustom = {
        \ "Modified"  : "✹",
        \ "Staged"    : "✚",
        \ "Untracked" : "✭",
        \ "Renamed"   : "➜",
        \ "Unmerged"  : "═",
        \ "Deleted"   : "✖",
        \ "Dirty"     : "✗",
        \ "Clean"     : "✔︎",
        \ 'Ignored'   : '☒',
        \ "Unknown"   : "?"
        \ }
let g:NERDTreeShowHidden=1


autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" ************************************************************************ 


" ************************Fugitive********************************
au FileType gitcommit setlocal completefunc=emoji#complete
au FileType gitcommit nnoremap <buffer> <silent> cd :<C-U>Gcommit --amend --date="$(date)"<CR>

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

"************************************************************************


" ************************FZF Config********************************

fun! FzfOmniFiles()
	 let is_git = system('git status')
	 if v:shell_error
		 :Files
	else
		:GFiles --exclude-standard -o
	endif
endfun

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
  au BufNewFile,BufRead *.js         set filetype=javascript
  au BufNewFile,BufRead *.jsx 		   set filetype=javascript
  au BufNewFile,BufRead *.ts         set filetype=typescript
  au BufNewFile,BufRead *.tsx        set filetype=typescript
  au BufNewFile,BufRead *.hs		     set filetype=haskell
"************************************************************************
  
let g:ackprg = 'rg --vimgrep --no-heading'

" ***************** KEY MAPPINGS ********************

let mapleader = "\<Space>"

nmap <silent> <leader>, :nohl<cr>

nmap <Leader>a :Ack!<Space>
nmap <Leader>F :Files<CR>
nmap <Leader>G :GFiles<CR>
nmap <Leader>B :Buffers<CR>

" Ctag mapping
nmap <Leader>d <c-]>
nmap <Leader>i <c-T>

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" NerdTree Toggle
nmap <silent> <C-n> :NERDTreeToggle<CR>

" Neovim Terminal Mappings
tnoremap <Esc> <C-\><C-n>

" Remap To Normal Mode
inoremap jj <esc>
" ************************************************


" **************** GIT ********************

" Automatically wrap at 100 characters and spell check git commit messages
autocmd FileType gitcommit setlocal textwidth=100
autocmd FileType gitcommit setlocal spell

" ************************************************

" Enable spellchecking for Markdown
autocmd FileType markdown setlocal spell


" ******************** Themes *******************
colorscheme gruvbox  
" ************************************************



" ************** Haskell Intero ******************
augroup interoMaps
  au!
  " Maps for intero. Restrict to Haskell buffers so the bindings don't collide.
  " Background process and window management
  au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
  au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>

  " Open intero/GHCi split horizontally
  au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR>
  " Open intero/GHCi split vertically
  au FileType haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
  au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>

  " Reloading (pick one)
  " Automatically reload on save
  au BufWritePost *.hs InteroReload
  " Manually save and reload
  au FileType haskell nnoremap <silent> <leader>wr :w \| :InteroReload<CR>

  " Load individual modules
  au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>

  " Type-related information
  " Heads up! These next two differ from the rest.
  au FileType haskell map <silent> <leader>t <Plug>InteroGenericType
  au FileType haskell map <silent> <leader>T <Plug>InteroType
  au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>

  " Navigation
  au FileType haskell nnoremap <silent> <leader>jd :InteroGoToDef<CR>

  " Managing targets
  " Prompts you to enter targets (no silent):
  au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>
augroup END

" Enable type information on hover (when holding cursor at point for ~1 second).
let g:intero_type_on_hover = 1

" OPTIONAL: Make the update time shorter, so the type info will trigger faster.
set updatetime=1000

" ************************************************

set background=dark
syntax on
