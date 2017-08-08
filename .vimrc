set nocompatible
filetype off
let &runtimepath.=',~/.vim/bundle/ale'
filetype plugin indent on
syntax enable
set termguicolors
hi Comment cterm=italic
set smartindent
set showmatch
set textwidth=100
set autoindent
set statusline=%{fugitive#statusline()}

" colorscheme
colorscheme molokai

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim

set number

"KEY MAPPINGS
" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
nmap <C-n> :NERDTreeToggle<CR>
"
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'crusoexia/vim-javascript-lib'
Plugin 'neovimhaskell/haskell-vim'
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'wakatime/vim-wakatime'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'marijnh/tern_for_vim'
Plugin 'ctrlpvim/ctrlp.vim.git'
Plugin 'Shougo/vimproc.vim', {'do' : 'make'}
Plugin 'Shougo/vimshell.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'elzr/vim-json'
Plugin 'tpope/vim-commentary'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'w0rp/ale'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mattn/emmet-vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'easymotion/vim-easymotion'
Plugin 'leafgarland/typescript-vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'prettier/prettier-eslint-cli'
Plugin 'mitermayer/vim-prettier', {
	\ 'do': 'yarn install',
	\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss'] }


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

let g:CommandTAcceptSelectionMap = '<C-t>'
let g:CommandTAcceptSelectionTabMap = '<CR>'


"vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
"vim-jsx
let g:jsx_ext_required = 0
" delimitmate
" CTRL + C
imap <C-c> <CR><Esc>O

"Syntastic linting
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:ale_emit_conflict_warnings = 0
let g:syntastic_always_populate_loc_list = 0 " show log
let g:syntastic_auto_loc_list = 0 " show log
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { "mode": "passive" }
let g:syntastic_javascript_checkers = ['eslint']
map <C-l> :SyntasticCheck<cr>

" ALE Setup
let g:ale_linters = {'jsx': ['stylelint', 'eslint']}
let g:ale_linter_aliases = {'jsx': 'css'}
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme='simple'

" NERDTREE
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" YCM gives you popups and splits by default that some people might not like, so these should tidy it up a bit for you.
let g:ycm_add_preview_to_completeopt=1
let g:ycm_confirm_extra_conf=0
set completeopt-=preview
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

" Typescript
let g:typescript_indent_disable = 1
let g:typescript_opfirst='\%([<>=,?^%|*/&]\|\([-:+]\)\1\@!\|!=\|in\%(stanceof\)\=\>\)'
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''

" CTRL P
" Set no max file limit
let g:ctrlp_max_files = 0

" Prettier setup
let g:prettier#autoformat = 0
autocmd FileType javascript set formatprg=prettier-eslint

let g:prettier#config#print_width = 100
let g:prettier#config#tab_width = 2
let g:prettier#config#use_tabs = 'false'
let g:prettier#config#semi = 'true'
let g:prettier#config#semi = 'true'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'true'
let g:prettier#config#trailing_comma = 'all'

autocmd BufWritePre *.js,*.json,*.css,*.scss,*.less,*.graphql Prettier
" Search from current directory instead of project root
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'


"Editor Config
let g:EditorConfig_exec_path = './.editorconfig'
