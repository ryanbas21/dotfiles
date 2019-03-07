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

  source $antigen
  antigen use oh-my-zsh
  antigen bundles <<EOBUNDLES
    pip
    cabal
    dotenv
    lein
    command-not-found
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-syntax-highlighting 
EOBUNDLES
  antigen bundle wfxr/forgit
  antigen bundle fzf-zsh

source $ZSH/oh-my-zsh.sh
source ~/dotfiles/zsh/functions
source ~/dotfiles/zsh/zsh.keybindings.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
ZSH_THEME="agnoster"

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias vim="nvim"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
  # Set theme
  antigen theme bhilburn/powerlevel9k powerlevel9k
  antigen apply

POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind git-remotebranch git-tagname)
POWERLEVEL9K_WHITESPACE_BETWEEN_RIGHT_SEGMENTS=''

# vcs
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_CHANGESET_HASH_LENGTH=6

POWERLEVEL9K_VCS_CLEAN_BACKGROUND='none'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='076'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='none'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='005'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='none'

