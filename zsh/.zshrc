export DEFAULT_USER=`whoami`
export TERM="xterm-256color"
export VISUAL=nvim
export EDITOR='$VISUAL'

export PATH=/usr/local/opt/ruby/bin:$PATH
export GEM_HOME=/usr/local/opt/ruby/lib/ruby/gems/2.5.0
export GEM_PATH=/usr/local/opt/ruby/lib/ruby/gems/2.5.0

alias ohmyzsh="mate ~/.oh-my-zsh"

export TERM="xterm-256color"
export ZSH=~/.oh-my-zsh

[ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--no-height'

ZSH_THEME="powerlevel9k/powerlevel9k"
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

source $ZSH/oh-my-zsh.sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/zsh/functions
source ~/dotfiles/zsh/zsh.keybindings.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='
--color dark,hl:33,hl+:37,fg+:235,bg+:136,fg+:254
--color info:254,prompt:37,spinner:108,pointer:235,marker:235
'

if [ -x ~/.vim/plugged/fzf.vim/bin/preview.rb ]; then
  export FZF_CTRL_T_OPTS="--preview '~/.vim/plugged/fzf.vim/bin/preview.rb {} | head -200'"
fi

export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"


plugins=(zsh-syntax-highlighting )
# NVM
#
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

fpath=(./zsh "${fpath[@]}")

autoload -Uz kp bip bup bcp buu cani 

# bindkey '^g^t' fzf-gt-widget
# bindkey '"\er": redraw-current-line'
# bindkey '"^g^f": "$(gf)\e\C-e\er"'
# bindkey '"^g^b": "$(gb)\e\C-e\er"'
# bindkey '"^g^h": "$(gh)\e\C-e\er"'
# bindkey '"^g^r": "$(gr)\e\C-e\er"'

# use nvim, but don't make me think about it
alias vim="nvim"

# Alias to reload zshrc 
alias reload="source ~/dotfiles/zsh/.zshrc"

Fortune | cowsay -f vader 
