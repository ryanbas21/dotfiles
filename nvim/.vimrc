filetype plugin indent on
set guifont=Fire\ Code\:h20
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

" Color / Themes
Plug 'patstockwell/vim-monokai-tasty'
Plug 'itchyny/lightline.vim'
" Haskell
 Plug 'parsonsmatt/intero-neovim', { 'for': ['haskell'] }
" GIT
Plug 'tpope/vim-fugitive'
" Movement
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" Tags
Plug 'ludovicchabant/vim-gutentags'

" Junegunn
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
Plug 'junegunn/vim-xmark', { 'do': 'make', 'for': [ 'markdown', 'md' ] }

" Syntax
Plug 'neovimhaskell/haskell-vim'
Plug 'sheerun/vim-polyglot'
Plug 'alx741/vim-hindent'
Plug 'moll/vim-node'
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'typescript', 'typescript.react', 'javascript.react']}
Plug 'mxw/vim-jsx', {'for': ['javascript', 'typescript', 'typescript.react', 'javascript.react']}
Plug 'parsonsmatt/vim2hs', { 'for': ['haskell'] }
Plug 'leafgarland/typescript-vim',  {'for': ['typescript', 'typescript.react']}
" Completion
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}, 'for': ['javascript, typescript, javascript.react', 'typescript.react', 'tsx', 'jsx', 'python', 'yaml', 'json']}
Plug 'w0rp/ale'
" File Tree
Plug 'tpope/vim-vinegar' 
" Other
Plug 'tpope/vim-dispatch'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'yuttie/comfortable-motion.vim'
Plug 'junegunn/goyo.vim'  
call plug#end()


"************************vim-jsx******************
let g:jsx_ext_required = 0
" ******************************************************
" ************************ALE Setup******************************
 let b:ale_open_list = 1 
 let g:ale_lint_on_text_changed = 'never'
 let g:ale_fix_on_save = 1
 let g:ale_set_quickfix = 1
 let g:ale_emit_conflict_warnings = 1
 let g:ale_fixers = { 'css': ['prettier'], 'javascript': ['prettier'], 'typescript' : ['prettier'], 'haskell': ['brittany'], 'vue': ['prettier'] }
 let g:ale_linters = { 'javascript': ['eslint', 'prettier'], 'typescript' : ['tsserver', 'tslint', 'prettier'], 'haskell': ['stack-ghc-mod', 'hlint']}
" ************************************************************

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
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
cnoreabbrev Wall wall 
cnoreabbrev Qall qall

"
noremap YY "+y<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

" Tree style list
let g:netrw_liststyle = 3
" Function for toggle netrw
function! ToggleVExplorer()
    if exists("t:expl_buf_num")
        let expl_win_num = bufwinnr(t:expl_buf_num)
        let cur_win_num = winnr()

        if expl_win_num != -1
            while expl_win_num != cur_win_num
                exec "wincmd w"
                let cur_win_num = winnr()
            endwhile

            close
        endif

        unlet t:expl_buf_num
    else
         20Vexplore
         let t:expl_buf_num = bufnr("%")
    endif
endfunction

let g:netrw_altv=1

" ************** Key Mappings *******************************************  
let mapleader = "\<Space>"
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
nmap <silent> <leader>, :nohl<cr>
map <silent> <C-n> :call ToggleVExplorer()<CR>
" Mappings for easier pasting through registers
xnoremap ,p "0p
nnoremap ,p "0p

"escaping
inoremap jk <Esc>

nmap <Leader>C :call fzf#run({
\   'source':
\     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
\         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
\   'sink':    'colo',
\   'options': '+m',
\   'left':    30
\ })<CR>

" FZF Mappings
nnoremap <silent> <Leader>F :Files<CR>
nnoremap <silent> <Leader>f :GFiles<CR>
nnoremap <silent> <Leader><Leader> :FZFMru<CR>
nnoremap <silent> <Leader>C :Commits<CR>
nnoremap <silent> <Leader>c :Colors<CR>
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <silent> <Leader>b :Buffers <CR>
nnoremap <Leader>t :BTags<CR>
nnoremap <Leader>T :Tags<CR>
nnoremap <Leader>H :History<CR>
nnoremap <Leader>s :GGrep<space> 
nnoremap <Leader>S :GGrep<space><C-r><C-w><CR>

" git 
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gb :Gblame<CR>
nmap <Leader>gca :Gcommit --amend<CR>
nmap <Leader>gp :Gpush origin<space>
nmap <Leader>gaa :Git add .<CR>

" Use MRU
let g:fzf_mru_relative = 1

" ************Coc******************

" use <tab> for trigger completion and navigate next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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

" Test File
nmap <silent> <C-t> :Dispatch<CR>

"*************** LightLine ***********************
  let g:lightline = {
      \ 'colorscheme': 'monokai_tasty',
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
let g:fzf_nvim_statusline = 0

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({ 'dir': systemlist('git rev-parse --show-toplevel')[0] }), <bang>0)


set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" 
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags . -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
" Default fzf layout " - down / up / left / right let g:fzf_layout = { 'up': '~10%' }

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
"
" ************** Haskell ******************
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
  au FileType haskell nnoremap <silent> <C-]> :InteroGoToDef<CR>

  " Managing targets
  " Prompts you to enter targets (no silent):
  au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>
augroup end

" Enable type information on hover (when holding cursor at point for ~1 second).
let g:intero_type_on_hover = 1

" OPTIONAL: Make the update time shorter, so the type info will trigger faster.
set updatetime=100

" ************************************************
" " ----- neovimhaskell/haskell-vim -----

" Align 'then' two spaces after 'if'
let g:haskell_indent_if = 2
" Indent 'where' block two spaces under previous body
let g:haskell_indent_before_where = 2
" Allow a second case indent style (see haskell-vim README)
let g:haskell_indent_case_alternative = 1
" Only next under 'let' if there's an equals sign
let g:haskell_indent_let_no_in = 0

" ----- hindent & stylish-haskell -----
let g:hindent_on_save = 1
" *************************************************

set statusline+=%{gutentags#statusline()}
let g:gutentags_generate_on_empty_buffer = 1

augroup MyGutentagsStatusLineRefresher
  autocmd!
  autocmd User GutentagsUpdating call lightline#update()
  autocmd User GutentagsUpdated call lightline#update()
augroup END

set bg=dark

let g:vim_monokai_tasty_italic = 1
colorscheme vim-monokai-tasty 

syntax on
