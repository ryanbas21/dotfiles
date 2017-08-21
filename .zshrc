export TERM="xterm-256color"
set -o vi
export ZSH=/Users/RyanBas/.oh-my-zsh
DEFAULT_USER=`whoami`

ZSH_THEME="powerlevel9k/powerlevel9k"
source $ZSH/oh-my-zsh.sh

plugins=(git,fzf-zsh)
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias ohmyzsh="mate ~/.oh-my-zsh"

export PATH=/usr/local/gnupg-2.1/bin:$PATH
 alias status='git status'
 alias add='git add'
 alias checkout='git checkout'
 alias commit='git commit -m'
 alias push='git push'
 alias ls='ls -a'
 alias web='cd ~/Documents/web_development';
 alias mentorship='cd ~/Documents/web_development/eric-elliot-mentorship'
 alias haskell='cd ~/Documents/haskell'
 alias python= 'cd ~/Documents/python'
 alias scala= 'cd ~/Documents/scala'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export FZF_DEFAULT_OPTS="--extended"
source ~/zsh.keybindings.sh

# Feed the output of ag into fzf
ag -g "" | fzf

# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'

# Now fzf (w/o pipe) will use ag instead of find
fzf


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
