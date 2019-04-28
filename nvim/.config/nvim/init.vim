set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
   if !has('nvim')
        set termguicolors
        set ttymouse=xterm2
   endif
source ~/dotfiles/nvim/.vimrc
