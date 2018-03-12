export TERM="xterm-256color"
set -o vi
export ZSH=/Users/RyanBas/.oh-my-zsh
DEFAULT_USER=`whoami`

ZSH_THEME="powerlevel9k/powerlevel9k"
source $ZSH/oh-my-zsh.sh

plugins=(git)
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/zsh.keybindings.sh

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
export FZF_ALT_C_COMMAND='ag --ignore .git -g ""'

# Feed the output of fd into fzf
fd --type f | fzf

# Now fzf (w/o pipe) will use fd instead of find
fzf

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --follow --glob "!.git/*"'



[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
