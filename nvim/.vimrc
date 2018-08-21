set guifont=Source\ Code\ Pro\ for\ Powerline:h20
autocmd! bufwritepost .vimrc source %

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
au FileType gitcommit,gitrebase let g:gutentags_enabled=0
autocmd BufEnter * silent! lcd %:p:h
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
Plug 'morhetz/gruvbox'
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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Syntax
Plug 'aanari/vim-tsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'parsonsmatt/vim2hs', { 'for': ['haskell'] }
Plug 'tpope/vim-commentary'
Plug 'leafgarland/typescript-vim' 
Plug 'Quramy/tsuquyomi'
Plug 'jiangmiao/auto-pairs'

" Completion
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
Plug 'Shougo/neomru.vim'
Plug 'Shougo/denite.nvim'
Plug 'w0rp/ale'
" File Tree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Documentation
Plug 'rizzatti/dash.vim'
" Other
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
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
 let g:ale_fix_on_save = 1
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
let g:NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.js$','\.js\.map' ]


autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

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

nmap <silent> <Leader>f :Files<CR>
nmap <silent> <Leader>C :Commits<CR>
nnoremap <silent> <leader>; :BLines<CR>

nmap <silent> <leader>ot :split term://zsh<cr>
nmap <silent> <leader>, :nohl<cr>
inoremap jk <Esc>

augroup DashVim
  au! 
  " Dash
  " Dash search under cursor
  nmap <silent> <leader>ds <Plug>DashSearch
  nmap <silent> <leader>da :Dash!<cr>  

augroup end

" Denite Mappings

" Color Scheme
nmap <Leader>dcs :Denite colorscheme -auto-preview -mode=normal <CR><CR>
" Fuzzy Finder

nmap <Leader>rf :DeniteProjectDir file_mru file_rec<CR>

" search file 
nmap <Leader>s :Find <CR>

"search word under cursor
nmap <Leader>cw :DeniteCursorWord grep:.<CR><Esc>

" jump to tag
nmap <Leader>ju :DeniteProjectDir jump<CR>

" cycle buffers
nmap <Leader>b :Denite buffer<CR>

" run previous commands
nmap <Leader>ch :DeniteProjectDir command_history<CR>

nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gb :Gblame<CR>
nmap <Leader>gca :Gcommit --amend<CR>
nmap <Leader>gp :Gpush origin<space>
nmap <Leader>gaa :Git add .<CR>

" Ctag mapping
" Definition
noremap <silent> <Leader>d <c-]>

" implementation
noremap <silent> <Leader>i <c-T>

" Typescript
let g:typescript_indent_disable = 1
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

augroup typescript_key_mapping
  autocmd FileType typescript nmap <buffer> <Leader>qf <Plug>(TsuquyomiQuickFix)
  autocmd FileType typescript nmap <buffer> <Leader>h :<C-u>echo tsuquyomi#hint()<CR>
  autocmd FileType typescript nmap <buffer> <Leader>ii <Plug>(TsuquyomiImport)
  autocmd FileType typescript nmap <buffer> <Leader>td <Plug>(TsuTypeDefinition)
  autocmd FileType typescript nmap <buffer> <Leader>ti <Plug>(:TsuImplementation)
augroup END


" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" NerdTree Toggle
nmap <silent> <C-n> :NERDTreeToggle<CR>

" map Y to yank from cursor to end of line
noremap <silent> Y y$

" Neovim Terminal Mappings
" ************************************************
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
" ************** DENITE **************************
  " reset 50% winheight on window resize
  augroup deniteresize
    autocmd!
    autocmd VimResized,VimEnter * call denite#custom#option('default',
          \'winheight', winheight(0) / 2)
  augroup end

  call denite#custom#option('default', {
          \ 'prompt': '❯'
          \ })

    call denite#custom#var('file_rec', 'command', 
          \ ['rg', '--files', '--glob', '!.git', ''])
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts',
          \ ['--hidden', '--vimgrep', '--no-heading', '-S'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
    call denite#custom#map('insert', 'jk', '<denite:enter_mode:normal>',
          \'noremap')
    call denite#custom#map('normal', '<Esc>', '<NOP>',
          \'noremap')
    call denite#custom#map('normal', 's', '<denite:do_action:vsplit>',
          \'noremap')
    call denite#custom#map('normal', 'dw', '<denite:delete_word_after_caret>',
          \'noremap')

" **************************************************

" **************** GIT ********************

" Automatically wrap at 100 characters and spell check git commit messages
autocmd FileType gitcommit setlocal textwidth=100
autocmd FileType gitcommit setlocal spell

" ************************************************

" Enable spellchecking for Markdown
autocmd FileType markdown setlocal spell


" ******************** Themes *******************
colorscheme hybrid_material
" ************************************************

" ************** FZF *****************************
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
let g:fzf_layout = { 'up': '~20%' }

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

command! TERMLOW split | resize 10 | terminal

syntax on
