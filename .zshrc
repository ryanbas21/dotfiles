export TERM="xterm-256color"
set -o vi
export ZSH=/Users/rbasmajian/.oh-my-zsh
DEFAULT_USER=`whoami`

ZSH_THEME="powerlevel9k/powerlevel9k"
source $ZSH/oh-my-zsh.sh

plugins=(git npm)

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

alias ohmyzsh="mate ~/.oh-my-zsh"
export PATH=/usr/local/gnupg-2.1/bin:$PATH

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# FZF SETTINGS
rg --type f | fzf
export FZF_DEFAULT_COMMAND='rg --files -g "!{.git,node_modules}/*" 2> /dev/null' 

fzf --preview '[[ $(file --mime {}) =~ binary ]] &&
                 echo {} is a binary file ||
                 (highlight -O ansi -l {} ||
                  coderay {} ||
                  rougify {} ||
                  cat {}) 2> /dev/null | head -500'


vim $(fzf --height 40% --reverse --border)
complete -F _fzf_path_completion -o default -o bashdefault ag
complete -F _fzf_dir_completion -o default -o bashdefault tree

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


