set guifont=Fira\ Code\:h20
set ttimeout
set ttimeoutlen=0
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
set cc=0
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
au FileType gitcommit,gitrebase,tags,md,yml,yaml,json,map, let g:gutentags_enabled=0
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
call plug#begin('~/.vim/plugged')
Plug 'haishanh/night-owl.vim' " color scheme
Plug 'itchyny/lightline.vim'  " status line
Plug 'tpope/vim-fugitive' " Git 
Plug 'tpope/vim-repeat' " Make dot command better
Plug 'tpope/vim-surround' " quotes/blocks/tags and more manipulation
Plug 'tpope/vim-commentary' " comment out stuff
Plug 'tpope/vim-projectionist' " switch between test files or create them
Plug 'tpope/vim-unimpaired' 
Plug 'tpope/vim-eunuch' " Added Unix command capability for vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " FZF Terminal installation
Plug 'junegunn/goyo.vim'   " Distraction free writing 
Plug 'junegunn/limelight.vim'  " highlight the focus area
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-xmark', { 'do': 'make', 'for': [ 'markdown', 'md' ] } " markdown previewer
Plug 'easymotion/vim-easymotion'
Plug 'sheerun/vim-polyglot'
Plug 'pbogut/fzf-mru.vim'
Plug 'neovimhaskell/haskell-vim', { 'for': ['haskell'] }
Plug 'mxw/vim-jsx', {'for': ['javascript', 'typescript', 'typescript.react', 'javascript.react']}
Plug 'parsonsmatt/vim2hs', { 'for': ['haskell'] }
Plug 'neoclide/coc.nvim', {'do': 'yarn install' } 
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'rhysd/git-messenger.vim'
Plug 'neoclide/coc-neco'
Plug 'w0rp/ale' " Linting
Plug 'scrooloose/nerdtree' " file tree
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'yuttie/comfortable-motion.vim' " better scrolling
call plug#end()


autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

"************************vim-jsx******************
let g:jsx_ext_required = 0
" ******************************************************

" ************************ALE Setup******************************
let g:ale_disable_lsp = 1
let g:ale_list_window_size = 5
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1
let g:ale_fixers = { 'css': ['prettier'], 'javascript': ['prettier'], 'typescript' : ['prettier'], 'vue': ['prettier'] }
let g:ale_linter_aliases = {'js': ['jsx',  'typescript', 'tsx', 'vue', 'javascript']}
let g:ale_linters = { 
      \ '*': ['remove_trailing_lines', 'trim_whitespace'], 'js': ['eslint'], 
      \ 'typescript' : ['tsserver'], 'haskell': ['stack-ghc-mod', 'hlint']}

nmap <silent> [c <Plug>(ale_previous_wrap)
nmap <silent> ]c <Plug>(ale_next_wrap)
let g:ale_fix_on_save = 1
hi link ALEErrorSign    Error
hi link ALEWarningSign  Warning
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
" ************************************************************
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
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
nnoremap <leader>c :CocList -N --top --ignore-case<CR>
nnoremap <leader>y :CocList -N --top --ignore-case yank<CR>

"Jest 
" Run jest for current project
command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')

" Run jest for current file
command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])

" Run jest for current test
nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>

nnoremap <c-t>c :call CocAction('runCommand', 'jest.fileTest', ['%'])<CR>

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'top': '13%'})
" flip back to last buffer
nmap ,, <C-^>
let mapleader = "\<Space>"
" create a new file
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" Remove that dumb search highlight
nmap <silent> <leader>, :nohl<cr>
"escaping
inoremap jk <Esc>

" FZF Mappings
nnoremap <silent> <Leader>F :Files<CR>
nnoremap <silent> <Leader>f :GFiles<CR>
nnoremap <silent> <Leader><Leader> :FZFMru<CR>
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <Leader>s :GGrep<space> 
nnoremap <Leader>S :GGrep<space><C-r><C-w><CR>

let g:coc_status_error_sign = '•'
let g:coc_status_warning_sign = '••'

" git 
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gb :Gblame<CR>
nmap <Leader>gp :Gpush origin<space>

" Use MRU
let g:fzf_mru_relative = 1

" ************Coc******************
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
let g:coc_status_error_sign = '•'
let g:coc_status_warning_sign = '••'

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use tab and shift tab to navigate completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Use Enter for coc completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

augroup mygroup
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd CursorHold * call CocActionAsync('doHover')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <C-i> <Plug>(coc-implementation)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

command! -nargs=0 Tsc :call CocAction('runCommand', 'tsserver.watchBuild')

inoremap <silent><expr> <c-space> coc#refresh()
imap <silent> <C-x><C-o> <Plug>(coc-complete-custom)

" ***************************************
" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" map Y to yank from cursor to end of line
noremap <silent> Y y$
"*************** LightLine ***********************
  let g:lightline = {
      \ 'colorscheme': 'monokai_tasty',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status'
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

"NerdTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Easy Motion "
map <Leader> <Plug>(easymotion-prefix)
nmap <Leader>L <Plug>(easymotion-overwin-line)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" ************** FZF *****************************
let g:fzf_nvim_statusline = 0

set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

inoremap <expr> <c-x><c-s> fzf#vim#complete({
  \ 'source':  'bat /usr/share/dict/words',
  \ 'reducer': function('<sid>make_sentence'),
  \ 'options': '--multi --reverse --margin 15%,0',
  \ 'left':    20})

inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
      \ 'prefix': '^.*$',
      \ 'source': 'rg -n ^ --color always',
      \ 'options': '--ansi --delimiter : --nth 3..',
      \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags . -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

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
      \         '{dirname}/__tests__/{basename}-test.js',
      \         '{dirname}/__tests__/{basename}-mocha.js'
      \       ],
      \       'type': 'source'
      \     },
      \     '*.test.js': {
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

set bg=dark
let g:vim_monokai_tasty_italic = 1
if (has("termguicolors"))
 set termguicolors
endif

let g:UltiSnipsExpandTrigger="<tab>"
tnoremap <Esc> <C-\><C-n>
" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme night-owl
syntax on
