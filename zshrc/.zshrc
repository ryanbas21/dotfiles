# =============================================================================
# Powerlevel10k Instant Prompt (MUST be at the top)
# =============================================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

export BORG_PASSPHRASE=$(pass show BORG/password)
# =============================================================================
# Zplug Plugin Manager
# =============================================================================
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

if ! zplug check; then
  zplug install
fi

zplug load

# =============================================================================
# Environment Variables
# =============================================================================
export TERM="xterm-256color"
export EDITOR=nvim
export DEFAULT_USER=$(whoami)
export DOTENVENC_KEY=''
export GPG_TTY=$(tty)

export UID=$(id -u)
export GID=$(id -g)
export OP_BIOMETRIC_UNLOCK_ENABLED=true
export GOOGLE_CLOUD_PROJECT=ryan-bas-sdk

# =============================================================================
# Secrets via pass (LAZY LOADED - massive speedup)
# =============================================================================
# Secrets are loaded on first access, not at shell startup
# This saves 2-4 seconds of GPG decryption time

_load_secret() {
  local var_name=$1
  local pass_path=$2
  eval "
    $var_name() {
      unset -f $var_name
      local secret
      if secret=\$(pass show $pass_path 2>/dev/null); then
        export $var_name=\"\$secret\"
        echo \$$var_name
      else
        echo \"Failed to load secret: $pass_path\" >&2
        return 1
      fi
    }
  "
}

# Define lazy loaders - secrets load on first use
_load_secret CACHIX_AUTH_TOKEN CACHIX/pat
_load_secret DEPOT_TOKEN DEPOT/pat
_load_secret CLAUDE_CODE_OAUTH_TOKEN anthropic/oauth_token
_load_secret JIRA_API_TOKEN JIRA/pat
_load_secret CONTEXT7_PAT CONTEXT7/pat

# For tokens needed by CLI tools, use a function to load all at once
load-secrets() {
  export CACHIX_AUTH_TOKEN=$(pass show CACHIX/pat)
  export DEPOT_TOKEN=$(pass show DEPOT/pat)
  export CLAUDE_CODE_OAUTH_TOKEN=$(pass show anthropic/oauth_token)
  export GH_TOKEN=$(pass show GITHUB/pat)
  export GITHUB_TOKEN=$GH_TOKEN
  export BRAVE_SEARCH_API_KEY=$(pass show BRAVE/pat)
  export BRAVE_API_KEY=$(pass show BRAVE/pat)
  export JIRA_API_TOKEN=$(pass show JIRA/pat)
  export CONTEXT7_PAT=$(pass show CONTEXT7/pat)
  echo "All secrets loaded."
}

# GitHub token is often needed immediately by git/gh - lazy load it
gh() {
  if [[ -z "$GH_TOKEN" ]]; then
    export GH_TOKEN=$(pass show GITHUB/pat)
    export GITHUB_TOKEN=$GH_TOKEN
  fi
  command gh "$@"
}

# =============================================================================
# PATH Configuration
# =============================================================================
export PROTO_HOME="$HOME/.proto"
export PNPM_HOME="$HOME/.local/share/pnpm"

path=(
  "$PROTO_HOME/shims"
  "$PROTO_HOME/bin"
  "$PNPM_HOME"
  "$HOME/.local/bin"
  "$HOME/.cache/rebar3/bin"
  "/usr/local/bin/opam"
  "/var/lib/snapd/snap/bin"
  "$HOME/.proto/tools/node/globals/bin"
  $path
)
export PATH

[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
[[ -f "$HOME/.ghcup/env" ]] && . "$HOME/.ghcup/env"

# =============================================================================
# Aliases
# =============================================================================
alias nano=nvim
alias vim=nvim
alias cat=bat
alias reload="source ~/.zshrc"

# Linux-only aliases (X11 clipboard and display management)
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  alias copy='xclip -selection clipboard'
  alias laptopscreen='xrandr --output DP-2 --off --output eDP-1 --auto --primary'
  alias externalscreen='xrandr --output DP-2 --mode 2560x1600 --rate 165'
elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias copy='pbcopy'
fi

# =============================================================================
# FZF Configuration
# =============================================================================
[ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--no-height'

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --follow --hidden -E .git -E node_modules -E .stack-work'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# FZF keybindings and completion (Arch Linux paths)
[[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh
[[ -f ~/fzf-gitbindings.zsh ]] && source ~/fzf-gitbindings.zsh

# =============================================================================
# History Configuration
# =============================================================================
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e

# =============================================================================
# Completion System (cached for speed)
# =============================================================================
zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit

# Only regenerate compinit cache once per day
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C  # Use cached version
fi

# =============================================================================
# Tool Initialization (with caching where possible)
# =============================================================================

# Proto - cache the output
_proto_cache="$HOME/.cache/proto-init.zsh"
if [[ ! -f "$_proto_cache" ]] || [[ $(command -v proto) -nt "$_proto_cache" ]]; then
  proto activate zsh > "$_proto_cache" 2>/dev/null
fi
[[ -f "$_proto_cache" ]] && source "$_proto_cache"

# pnpm completions
[[ -f ~/completion-for-pnpm.zsh ]] && source ~/completion-for-pnpm.zsh

# opam configuration
[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null

# =============================================================================
# Direnv Configuration
# =============================================================================
if [[ "$OSTYPE" == "darwin"* ]]; then
  export DIRENV_BASH="/opt/homebrew/bin/bash"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  export DIRENV_BASH="/usr/bin/bash"
fi

# Cache direnv hook
_direnv_cache="$HOME/.cache/direnv-hook.zsh"
if [[ ! -f "$_direnv_cache" ]] || [[ $(command -v direnv) -nt "$_direnv_cache" ]]; then
  direnv hook zsh > "$_direnv_cache" 2>/dev/null
fi
[[ -f "$_direnv_cache" ]] && source "$_direnv_cache"

# nix-direnv stdlib
for f in /usr/share/nix-direnv/direnvrc \
         "$HOME/.nix-profile/share/nix-direnv/direnvrc" \
         "/etc/profiles/per-user/$USER/share/nix-direnv/direnvrc"
do
  [[ -e "$f" ]] && source "$f" && break
done

# =============================================================================
# Additional Completions (cached)
# =============================================================================
[[ -f ~/codex-bindings.zsh ]] && source ~/codex-bindings.zsh

# Cache p1-cli completions
_p1cli_cache="$HOME/.cache/p1-cli-completions.zsh"
if [[ ! -f "$_p1cli_cache" ]] || [[ $(command -v p1-cli) -nt "$_p1cli_cache" ]]; then
  p1-cli --completions zsh > "$_p1cli_cache" 2>/dev/null
fi
[[ -f "$_p1cli_cache" ]] && source "$_p1cli_cache"

# =============================================================================
# Powerlevel10k Theme Configuration
# =============================================================================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
