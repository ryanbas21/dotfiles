export DEFAULT_USER=`whoami`
export TERM="xterm-256color"
export VISUAL=nvim
export EDITOR='$VISUAL'
export antigen=$HOME/antigen.zsh
POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
export PATH=/usr/local/opt/ruby/bin:$PATH
export GEM_HOME=/usr/local/opt/ruby/lib/ruby/gems/2.5.0
export GEM_PATH=/usr/local/opt/ruby/lib/ruby/gems/2.5.0

alias ohmyzsh="mate ~/.oh-my-zsh"

export TERM="xterm-256color"
export ZSH=~/.oh-my-zsh

[ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--no-height'


## Set any customized theme options here
### Theme
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir user vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(time battery)
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# enable the vcs segment in general
POWERLEVEL9K_SHOW_CHANGESET=true

# just show the 6 first characters of changeset
POWERLEVEL9K_CHANGESET_HASH_LENGTH=6


### Antigen Plugin Management
alias reload="source ~/dotfiles/zsh/.zshrc"
# Antigen
if [[ -f $antigen ]]; then
  source $antigen
  echo '....Installing plugins....'
  # Load the oh-my-zsh's library
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
  antigen bundle jedahan/ripz

  # Set theme
  antigen theme bhilburn/powerlevel9k powerlevel9k
  antigen apply

else
  # Install antigen
  curl -L git.io/antigen > $HOME/antigen.zsh
  echo '.... Reloading after install .....'
  reload 
fi

source $ZSH/oh-my-zsh.sh
source ~/dotfiles/zsh/functions
source ~/dotfiles/zsh/zsh.keybindings.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'


if [ -x ~/.vim/plugged/fzf.vim/bin/preview.rb ]; then
  export FZF_CTRL_T_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
fi

export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

fpath=(./zsh "${fpath[@]}")

autoload -Uz kp bip bup bcp buu cani 

alias vim="nvim"

# Alias to reload zshrc 

Fortune | cowsay -f vader 
