if test -f ~/.gnupg/.gpg-agent-info -a -n "$(pgrep gpg-agent)"; then
  source ~/.gnupg/.gpg-agent-info
  export GPG_AGENT_INFO
  GPG_TTY=$(tty)
  export GPG_TTY
fi
export PATH="/usr/local/bin:${PATH}"
export VISUAL=nvim
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:/usr/lib:/usr/local/lib"
export PATH=$PATH:~/.local/bin/
export EDITOR=nvim
