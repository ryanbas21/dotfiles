export DEFAULT_USER=`whoami`
export TERM="xterm-256color"
export ZSH=/home/v1rgul/.oh-my-zsh
export VISUAL=nvim
export EDITOR='$VISUAL'

alias ohmyzsh="mate ~/.oh-my-zsh"

export TERM="xterm-256color"
export ZSH=~/.oh-my-zsh

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if [ -x ~/.vim/plugged/fzf.vim/bin/preview.rb ]; then
  export FZF_CTRL_T_OPTS="--preview '~/.vim/plugged/fzf.vim/bin/preview.rb {} | head -200'"
fi

export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"
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
source ~/dotfiles/zsh/functions.sh
source ~/dotfiles/zsh/vi-mode.zsh
source ~/dotfiles/zsh/zsh.keybindings.sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

plugins=(zsh-syntax-highlighting )
# NVM
#
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# complete -F _fzf_path_completion -o default -o bashdefault rg
# complete -F _fzf_dir_completion -o default -o bashdefault tree

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# use nvim, but don't make me think about it
alias vim="nvim"

### PROCESS
# mnemonic: [K]ill [P]rocess
# show output of "ps -ef", use [tab] to select one or multiple entries
# press [enter] to kill selected processes and go back to the process list.
# or press [escape] to go back to the process list. Press [escape] twice to exit completely.

# local pid=$(ps -ef | sed 1d | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[kill:process]'" | awk '{print $2}')

# if [ "x$pid" != "x" ]
# then
#   echo $pid | xargs kill -${1:-9}
#   kp
# fi

# ### PATH
# # mnemonic: [F]ind [P]ath
# # list directories in $PATH, press [enter] on an entry to list the executables inside.
# # press [escape] to go back to directory listing, [escape] twice to exit completely

# local loc=$(echo $PATH | sed -e $'s/:/\\\n/g' | eval "fzf ${FZF_DEFAULT_OPTS} --header='[find:path]'")

# if [[ -d $loc ]]; then
#   echo "$(rg --files $loc | rev | cut -d"/" -f1 | rev)" | eval "fzf ${FZF_DEFAULT_OPTS} --header='[find:exe] => ${loc}' >/dev/null"
#   fp
# fi


# ### Caniuse + FZF
# # caniuse for quick access to global support list
# # also runs the `caniuse` command if installed

# local feat=$(ciu | sort -rn | eval "fzf ${FZF_DEFAULT_OPTS} --ansi --header='[caniuse:features]'" | sed -e 's/^.*%\ *//g' | sed -e 's/   .*//g')

# if which caniuse &> /dev/null; then
#   if [[ $feat ]] then; caniuse $feat; fi
# fi

# ### BREW + FZF
# # mnemonic [B]rew [I]nstall [P]lugin

# local uninst=$(brew leaves | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[brew:clean]'")

# if [[ $uninst ]]; then
#   for prog in $(echo $uninst)
#   do brew uninstall $prog
#   done
# fi


# ### BREW + FZF
# # update multiple packages at once
# # mnemonic [B]rew [U]pdate [P]lugin

# local inst=$(brew search | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[brew:install]'")

# if [[ $inst ]]; then
#   for prog in $(echo $inst)
#   do brew install $prog
#   done
# fi
# ### BREW + FZF
# # uninstall multiple packages at once, async
# # mnemonic [B]rew [C]lean [P]lugin (e.g. uninstall)

# local upd=$(brew leaves | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[brew:update]'")

# if [[ $upd ]]; then
#   for prog in $(echo $upd)
#   do brew upgrade $prog
#   done
# fi
