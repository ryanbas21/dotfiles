set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source ~/dotfiles/nvim/.vimrc
   if !has('nvim')
        set ttymouse=xterm2
        set termguicolors
        set ttymouse=xterm2
        set termguicolors
        set background=dark
    endif
