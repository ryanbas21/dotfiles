# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#
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
zplug "ptavares/zsh-direnv"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    echo -n "Install? [y/N]: "
    read answer
    if [[ "$answer" == [Yy] ]]; then
        zplug install
    fi
fi

zplug load

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
alias laptopscreen=xrandr --output DP-2 --off --output eDP-1 --auto --primary
alias externalscreen=xrandr --output DP-2 --mode 2560x1600 --rate 165

export UID=$(id -u)
export GID=$(id -g)
export OP_BIOMETRIC_UNLOCK_ENABLED=true
export GOOGLE_CLOUD_PROJECT=ryan-bas-sdk

# load keys with pass
export CACHIX_AUTH_TOKEN=$(pass show CACHIX/pat)
export DEPOT_TOKEN=$(pass show DEPOT/pat)
export GH_TOKEN=$(pass show GITHUB/pat)
export GITHUB_TOKEN=$GH_TOKEN
export ANTHROPIC_API_KEY=$(pass show anthropic/pat)
export BRAVE_SEARCH_API_KEY=$(pass show BRAVE/pat)
export BRAVE_API_KEY=$(pass show BRAVE/pat)
export JIRA_API_TOKEN=$(pass show JIRA/pat)

export EDITOR=nvim
export DEFAULT_USER=`whoami`
export DOTENVENC_KEY='';
export TERM="xterm-256color"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias cat="bat"
export TERM="xterm-256color"
export ZSH=~/.oh-my-zsh
export REVIEW_BASE=master git review
export MYVIMRC="/Users/$DEFAULT_USER/dotfiles/nvim/init.vim"
export ZSH="$HOME/.oh-my-zsh"

export GPG_TTY=$(tty)
[ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--no-height'
alias reload="source ~/.zshrc"

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"


source $HOME/fzf-gitbindings.zsh

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

## NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias vim="nvim"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


source ~/dotfiles/zshrc/fzf-gitbindings.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ryan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export PROTO_HOME="$HOME/.proto"
PATH="$PROTO_HOME/shims:$PATH"
PATH="$PROTO_HOME/bin:$PATH"
PATH="/usr/local/bin/opam:$PATH"
PATH="$HOME/.cache/rebar3/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
export PATH


. "$HOME/.cargo/env"

[ -f "/home/ryan/.ghcup/env" ] && . "/home/ryan/.ghcup/env" # ghcup-envexport GPG_TTY=$(tty)
eval "$(proto activate zsh)"  # Add this line
source ~/completion-for-pnpm.zsh


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/ryan/.opam/opam-init/init.zsh' ]] || source '/home/ryan/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration
source ~/completion-for-pnpm.zsh
export DIRENV_BASH=/opt/homebrew/bin/bash
source ~/.nix-profile/share/nix-direnv/direnvrc
eval "$(direnv hook zsh)"
