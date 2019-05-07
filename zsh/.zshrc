export DEFAULT_USER=`whoami`
export TERM="xterm-256color"
alias ohmyzsh="mate ~/.oh-my-zsh"
export TERM="xterm-256color"
export ZSH=~/.oh-my-zsh

[ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--no-height'

bindkey -v

alias reload="source ~/.zshrc"
source $ZSH/oh-my-zsh.sh
source ~/dotfiles/zsh/functions
source ~/dotfiles/zsh/zsh.keybindings.sh
source ~/dotfiles/zsh/vi-mode.zsh

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

source ~/.zplug/init.zsh
  zplug "zsh-users/zsh-history-substring-search"
  zplug "plugins/git",   from:oh-my-zsh
  zplug 'wfxr/forgit'
  zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
  # Install plugins if there are plugins that have not been installed
  if ! zplug check --verbose; then
      printf "Install? [y/N]: "
      if read -q; then
          echo; zplug install
      fi
  fi
  zplug load 

  pw() {
    lpass show -c --password $(lpass ls  | fzf | awk '{print $(NF)}' | sed 's/\]//g')
  }

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
