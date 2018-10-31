set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

tnoremap <Esc> <C-\><C-n>
source ~/dotfiles/nvim/.vimrc
   if !has('nvim')
        set ttymouse=xterm2
        set termguicolors
        set ttymouse=xterm2
        set termguicolors
        set background=dark
        call dein#local('~/GitHub', {},['nvim-typescript'])
        let $NVIM_NODE_LOG_FILE='nvim-node.log'
        let $NVIM_NODE_LOG_LEVEL='warn'
    endif
