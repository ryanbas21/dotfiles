export TERM="xterm-256color"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim="nvim"
set -o vi

export ZSH=/Users/rbasmajian/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
DEFAULT_USER=`whoami`

source  ~/powerlevel9k/powerlevel9k.zsh-theme
POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(time battery rspec_stats)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_STATUS_VERBOSE=true
POWERLEVEL9K_VCS_GIT_GITHUB_ICON='\uE271'
POWERLEVEL9K_TIME_FOREGROUND="249"
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M} \uE12E"

# enable the vcs segment in general
POWERLEVEL9K_SHOW_CHANGESET=true
# just show the 6 first characters of changeset
POWERLEVEL9K_CHANGESET_HASH_LENGTH=6

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

export PATH=/usr/local/gnupg-2.1/bin:$PATH

plugins=(git npm)
# NVM
#
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


complete -F _fzf_path_completion -o default -o bashdefault rg
complete -F _fzf_dir_completion -o default -o bashdefault tree

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


