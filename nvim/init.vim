set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
   if !has('nvim')
        set termguicolors
        set ttymouse=xterm2
   endif
set guifont=Fira\ Code\:h20
set ttimeout
set ttimeoutlen=0
scriptencoding utf-8
set splitright
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


autocmd BufRead,BufNewFile *.md set filetype=markdown

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
au BufRead,BufNewFile *.sbt set filetype=scala
set termguicolors
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'  " status line
Plug 'chemzqm/vim-jsx-improve'
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release' }
Plug 'scrooloose/nerdtree' " file tree
Plug 'w0rp/ale' " Linting
Plug 'junegunn/goyo.vim'   " Distraction free writing 

Plug 'junegunn/limelight.vim'  " highlight the focus area
Plug 'junegunn/vim-xmark', { 'do': 'make', 'for': [ 'markdown', 'md' ] } " markdown previewer
" Coc Extension management"
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile', 'for': ['js', 'ts', 'javascript', 'typescript', 'jsx', 'tsx', 'vue']}
Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-neco', { 'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile', 'for': ['rls', 'rust']}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile', 'for': ['json']}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile', 'for': ['js', 'javascript', 'jsx', 'tsx']}
Plug 'neoclide/coc-pairs', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-emmet', {'do': 'yarn install --frozen-lockfile', 'for': ['html']}
Plug 'neoclide/coc-vetur', {'do': 'yarn install --frozen-lockfile', 'for': ['vue']}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile', 'for': ['py', 'python']}
Plug 'neoclide/coc-stylelint', {'do': 'yarn install --frozen-lockfile', 'for': ['less', 'css', 'scss']}
Plug 'neoclide/coc-solargraph', {'do': 'yarn install --frozen-lockfile', 'for': ['ruby', 'rb']}
Plug 'neoclide/coc-yank', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-smartf', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-java', {'do': 'yarn install --frozen-lockfile', 'for': ['java']}
Plug 'neoclide/coc-sources', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile', 'for': ['css']}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile', 'for': ['yaml']}
Plug 'neoclide/coc-jest', {'do': 'yarn install --frozen-lockfile', 'for': ['javascript', 'typescript', 'js', 'ts', 'tsx', 'jsx']}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile', 'for': ['html']}
Plug 'tpope/vim-fugitive' " Git 
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat' " Make dot command better
Plug 'tpope/vim-surround' " quotes/blocks/tags and more manipulation
Plug 'tpope/vim-commentary' " comment out stuff
Plug 'tpope/vim-projectionist' " switch between test files or create them
Plug 'tpope/vim-unimpaired' 
Plug 'tpope/vim-eunuch' " Added Unix command capability for vim
Plug 'sheerun/vim-polyglot' " all the syntax highlighting
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'joshdick/onedark.vim'

call plug#end()


autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" " ************************ALE Setup******************************
  let g:ale_linter_aliases = {'js': ['jsx',  'typescript', 'tsx', 'vue', 'javascript']}

  let g:ale_linters = { 
        \ '*': ['remove_trailing_lines', 'trim_whitespace'], 'js': ['eslint', 'prettier'], 
        \  'haskell': ['stack-ghc-mod', 'hlint']
        \ }

  let g:ale_fixers = { 'javascript': ['prettier'] }

  nmap <silent> [c <Plug>(ale_previous_wrap)
  nmap <silent> ]c <Plug>(ale_next_wrap)
  hi link ALEErrorSign    Error
  hi link ALEWarningSign  Warning
  let g:ale_set_quickfix = 1
  let g:ale_fix_on_save = 1
  let g:ale_open_list = 1
  let g:ale_disable_lsp = 1
" " ************************************************************

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
" Run jest for current project
command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')

" Run jest for current file
command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])

nnoremap <c-t>c :call CocAction('runCommand', 'jest.fileTest', ['%'])<CR>

" flip back to last buffer
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

inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
let g:coc_status_error_sign = '•'
let g:coc_status_warning_sign = '••'
nmap <leader>d :CocList diagnostics<CR>
nmap <leader>l :CocList
nnoremap <silent> <Leader>F :CocList  --ignore-case files<CR>
nnoremap <silent> <Leader>f :CocList  --ignore-case gfiles<CR>
nnoremap <silent> <Leader><Leader> :CocList  --ignore-case mru<CR>
nnoremap <silent> <leader>; :CocList --interactive  --ignore-case lines<CR>
nnoremap <Leader>s :CocList  --ignore-case grep<space> 
nnoremap <Leader>S :CocList  --ignore-case grep<space><C-r><C-w><CR>
nnoremap <leader>c :CocList -N  --ignore-case<CR>
nnoremap <leader>y :CocList -N  --ignore-case yank<CR>
nnoremap <leader>cmd :CocList -N  --ignore-case cmdhistory<CR>
nnoremap <leader>c :CocList -N  --ignore-case commands<CR>
nnoremap <leader>a :CocList -N  --ignore-case actions<CR>
nnoremap <leader>m :CocList marks<CR>

" grep selected visual group
vnoremap <leader>g :<C-u>call <SID>GrepFromSelected(visualmode())<CR> 


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

" ***************************************
" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" map Y to yank from cursor to end of line

function! LightlineObsession()
    return '%{ObsessionStatus()}'
endfunction

noremap <silent> Y y$
"*************** LightLine ***********************
  let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ ['percent', 'lineinfo'], [ 'fileformat', 'fileencoding', 'filetype', 'filesize' ],['obsession']],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status'
      \ },
      \ 'component_expand': {
      \   'obsession': 'LightlineObsession'
      \}
      \ }
"*************************************************

let g:fugitive_github_domains = ['github.homeawaycorp.com']

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
      \         '{dirname}/__tests__/{basename}-test.js',
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

if (has("termguicolors"))
 set termguicolors
endif

let g:UltiSnipsExpandTrigger="<tab>"
tnoremap <Esc> <C-\><C-n>
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax on
colorscheme onedark


set bg=dark
