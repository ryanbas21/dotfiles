set guifont=Source\ Code\ Pro\ for\ Powerline:h20

set ttimeout
set ttimeoutlen=0

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

set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim

" Make Searching Beter
set gdefault
set ignorecase

 " ctags optimization
au FileType gitcommit,gitrebase,tags,md,yml,yaml,json,map let g:gutentags_enabled=0

" autocmd BufEnter * silent! lcd %:p:h
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
Plug 'rafi/awesome-vim-colorschemes'
Plug 'itchyny/lightline.vim'

" Haskell
 Plug 'parsonsmatt/intero-neovim', { 'for': ['haskell'] }

" GIT
Plug 'tpope/vim-fugitive'

" Movement
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'ludovicchabant/vim-gutentags'

" Junegunn
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
Plug 'junegunn/vim-xmark', { 'do': 'make' }
" Syntax
Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'typescript'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'typescript'] }
Plug 'parsonsmatt/vim2hs', { 'for': ['haskell'] }
Plug 'tpope/vim-commentary'
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }
Plug 'Quramy/tsuquyomi', { 'for': ['typescript'] }
Plug 'jiangmiao/auto-pairs'

" Completion
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
Plug 'Shougo/neomru.vim'
Plug 'w0rp/ale'

" File Tree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Documentation
Plug 'rizzatti/dash.vim'

" Other
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'kassio/neoterm'
Plug 'janko-m/vim-test'

call plug#end()

" ********************************

" YCM gives you popups and splits by default that some people might not like, so these should tidy it up a bit for you.
nmap <C-f> :YcmCompleter FixIt<CR> 

autocmd FileType typescript :set makeprg=tsc
autocmd FileType typescript setlocal completeopt+=menu,preview
autocmd FileType typescript setl omnifunc=tsuquyomi#complete

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
"  ************************************************** 

"******************vim-javascript*******************
"
augroup javascript_syntax_detection
  au!  
  au FileType Javascript let g:javascript_plugin_jsdoc = 1
  au FileType Javascript let g:javascript_plugin_ngdoc = 1
  au FileType Javascript let g:javascript_plugin_flow = 1
augroup end
"******************************************************

" ************************************vim-jsx******************
let g:jsx_ext_required = 0
" ******************************************************

" ************************ALE Setup******************************
 let g:ale_emit_conflict_warnings = 1
 let g:airline#extensions#ale#enabled = 1
 let g:ale_sign_warning = '~~'
 let g:ale_echo_msg_warning_str = '**warning**'
 let g:ale_lint_on_text_changed = 'never'
 let g:ale_sign_errorle_echo_msg_error_str="✖"
 let g:ale_completion_enabled = 0 
 let g:ale_fix_on_save = 0
 let g:ale_fixers = { 'css': ['prettier'], 'javascript': ['prettier'], 'typescript' : ['prettier'], 'haskell': ['brittany'], 'vue': ['prettier'] }
 let g:ale_linters = { 'javascript': ['prettier'], 'typescript' : ['prettier'] }
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
augroup nerd_loader
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,BufNew *
        \  if isdirectory(expand('<amatch>'))
        \|   call plug#load('nerdtree')
        \|   execute 'autocmd! nerd_loader'
        \| endif
augroup END

let g:NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.js\.map' ]

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" ************************************************************************ 

" ********* File types ***************************************************
  au BufNewFile,BufRead *.js         set filetype=javascript
  au BufNewFile,BufRead *.jsx 		   set filetype=javascript
  au BufNewFile,BufRead *.ts         set filetype=typescript
  au BufNewFile,BufRead *.tsx        set filetype=typescript
  au BufNewFile,BufRead *.hs		     set filetype=haskell
  autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
  autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript
"************************************************************************

" ************** Key Mappings *******************************************  
let mapleader = "\<Space>"

nnoremap <silent> <Leader>P :ALEFix<CR>

nmap <silent> <leader>ot :split term://zsh<cr>
nmap <silent> <leader>, :nohl<cr>

"escaping
xnoremap jk <Esc>
cnoremap jk <C-c>
inoremap jk <Esc>

augroup DashVim
  au! 
  " Dash
  " Dash search under cursor
  nmap <silent> <leader>ds <Plug>DashSearch
  nmap <silent> <leader>da :Dash!<cr>  

augroup end

nmap <Leader>C :call fzf#run({
\   'source':
\     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
\         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
\   'sink':    'colo',
\   'options': '+m',
\   'left':    30
\ })<CR>

" FZF Mappings
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>g :GFiles<CR>
nnoremap <silent> <Leader><Leader> :FZFMru <CR>
nnoremap <silent> <Leader>C :Commits<CR>
nnoremap <silent> <Leader>c :Colors<CR>
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <Leader>t :BTags<CR>
nnoremap <Leader>T :Tags<CR>
nnoremap <Leader>H :History<CR>
nnoremap <Leader>s :Rg<space> 
nnoremap <Leader>S :Rg<space><C-r><C-w><CR>
nmap <Leader>b :Buffers <CR>

nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gb :Gblame<CR>
nmap <Leader>gca :Gcommit --amend<CR>
nmap <Leader>gp :Gpush origin<space>
nmap <Leader>gaa :Git add .<CR>

" Typescript
let g:typescript_indent_disable = 1
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

  nmap <buffer> <Leader>qf <Plug>(TsuquyomiQuickFix)
  nmap <buffer> <Leader>h :<C-u>echo tsuquyomi#hint()<CR>
  nmap <buffer> <Leader>ii <Plug>(TsuquyomiImport)
  nmap <Leader>] :TsuDefinition<CR>
  nmap <Leader>[ :TsuImplementation<CR>
  nmap <Leader>D :TsuTypeDefinition<CR>


" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" NerdTree Toggle
nmap <silent> <C-n> :NERDTreeToggle<CR>

" map Y to yank from cursor to end of line
noremap <silent> Y y$

"*************** LightLine ***********************
  let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
"*************************************************

" **************** GIT ********************

" Automatically wrap at 100 characters and spell check git commit messages
autocmd FileType gitcommit setlocal textwidth=100
autocmd FileType gitcommit setlocal spell

" ************************************************

" Enable spellchecking for Markdown
autocmd FileType markdown setlocal spell


" ************** FZF *****************************
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

let g:fzf_nvim_statusline = 0

set grepprg=rg\ --vimgrep
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'up': '~10%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }

" Customize fzf colors to match your color scheme
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
" ***********************************************
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

  " Automatically reload on save
  au BufWritePost *.hs InteroReload

  " Load individual modules
  au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>

  " Type-related information
  au FileType haskell map <silent> <leader>t <Plug>InteroGenericType
  au FileType haskell map <silent> <leader>T <Plug>InteroType
  au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>

  " Navigation
  au FileType haskell nnoremap <silent> <leader>jd :InteroGoToDef<CR>

  " Managing targets
  " Prompts you to enter targets (no silent):
  au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>
augroup end

" Enable type information on hover (when holding cursor at point for ~1 second).
let g:intero_type_on_hover = 1

" OPTIONAL: Make the update time shorter, so the type info will trigger faster.
set updatetime=100

" ************************************************
nmap  tN :TestNearest<CR> " t Ctrl+n
nmap  tF :TestFile<CR>    " t Ctrl+f
nmap  tS :TestSuite<CR>   " t Ctrl+s
nmap  tL :TestLast<CR>    " t Ctrl+l
nmap  tG :TestVisit<CR>   " t Ctrl+g
let test#strategy = "neoterm"
let g:test#preserve_screen = 1

colorscheme molokai
syntax on
