# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR=nvim
export DEFAULT_USER=`whoami`
export DOTENVENC_KEY='';
export TERM="xterm-256color"
alias ohmyzsh="mate ~/.oh-my-zsh"
export TERM="xterm-256color"
export ZSH=~/.oh-my-zsh
export NODE_PROJECTS_PATH="/Users/$DEFAULT_USER/programming"
export REVIEW_BASE=master git review
export MYVIMRC="/Users/$DEFAULT_USER/dotfiles/nvim/init.vim"
export ZSH="$HOME/.oh-my-zsh"

export GPG_TTY=$(tty)
[ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--no-height'
alias reload="source ~/.zshrc"
source $ZSH/oh-my-zsh.sh

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
## NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias vim="nvim"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.local/bin:$PATH:$HOME/.fnm"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh
zplug "romkatv/powerlevel10k", use:powerlevel10k.zsh-theme
zplug "zsh-users/zsh-autosuggestions"
zplug "wfxr/forgit"
zplug "urbainvaes/fzf-marks"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

eval "$(fnm env --use-on-cd --shell zsh)"

source ~/dotfiles/zshrc/fnm-bindings.zsh
source ~/dotfiles/zshrc/fzf-gitbindings.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f "/$HOME/.ghcup/env" ] && . "/$HOME/.ghcup/env" # ghcup-env

# pnpm
export PNPM_HOME="/home/$whoami/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
