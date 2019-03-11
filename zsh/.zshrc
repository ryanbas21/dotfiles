POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
export DEFAULT_USER=`whoami`
export PATH=$PATH:/Users/RyanBasmajian/.local/bin:/Users/RyanBasmajian/.npm/purs
export TERM="xterm-256color"
export VISUAL=nvim
export EDITOR='$VISUAL'
export antigen=$HOME/antigen.zsh
alias ohmyzsh="mate ~/.oh-my-zsh"
export TERM="xterm-256color"

export ZSH=~/.oh-my-zsh

[ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--no-height'

alias reload="source ~/dotfiles/zsh/.zshrc"
source $ZSH/oh-my-zsh.sh
source ~/dotfiles/zsh/functions
source ~/dotfiles/zsh/zsh.keybindings.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## FZF
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"

## NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


alias vim="nvim"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
  # Set theme

POWERLEVEL9K_MODE='powerlevel9k/powerlevel9k'
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_CHANGESET_HASH_LENGTH=6
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='076'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='005'
source $antigen
  antigen use oh-my-zsh
  antigen bundle pip
  antigen bundle cabal
  antigen bundle dotenv
  antigen bundle lein
  antigen bundle command-not-found
  antigen bundle zsh-users/zsh-autosuggestions
  antigen bundle zsh-users/zsh-syntax-highlighting 
  antigen bundle fzf-zsh
  antigen bundle wfxr/forgit
  antigen theme bhilburn/powerlevel9k powerlevel9k

antigen apply

