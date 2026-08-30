# Zsh, ported from the zplug-managed zshrc/.zshrc to home-manager.
# Junk dropped in the port: TERM override, UID/GID exports, all darwin
# branches, the eager BORG_PASSPHRASE load (moved into bin/backup.sh),
# the eager load-secrets call, and the triple fzf shell-integration
# loading. See docs/Shell.md.
{
  pkgs,
  ...
}: {
  # Runtime tools the rc and fzf integration depend on.
  home.packages = with pkgs; [
    bat # `cat` alias + fzf CTRL-T preview
    fd # fzf default listing
    tree # fzf ALT-C preview
    xclip # `copy` alias + fzf CTRL-R yank
    pass # lazy secrets
  ];

  # Static environment; dynamic vars (GPG_TTY, PROTO_HOME, ...) live in
  # programs.zsh.initExtra below.
  home.sessionVariables = {
    EDITOR = "nvim";
    DEFAULT_USER = "ryan";
    DOTENVENC_KEY = "";
    OP_BIOMETRIC_UNLOCK_ENABLED = "true";
    GOOGLE_CLOUD_PROJECT = "ryan-bas-sdk";
    CXXFLAGS = "-std=c++20";
    DIRENV_BASH = "/usr/bin/bash";
  };

  # Previously unmanaged (~/.p10k.zsh was never stowed); now tracked here.
  home.file.".p10k.zsh".source = ./zsh/p10k.zsh;

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Preserves the existing ~/.histfile (271KB of history).
    history = {
      path = "$HOME/.histfile";
      size = 10000;
      save = 10000;
    };

    # Instant prompt MUST be the first output of the generated .zshrc,
    # so the theme is sourced here rather than through a plugin.
    initExtraFirst = ''
      # =============================================================================
      # Powerlevel10k Instant Prompt (MUST be at the top)
      # =============================================================================
      typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
      source ${pkgs.zsh-powerlevel10k}/share/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
    '';

    plugins = [
      {
        name = "fzf-marks";
        src = pkgs.fetchFromGitHub {
          owner = "urbainvaes";
          repo = "fzf-marks";
          # master @ 2024-08-15 (latest upstream commit)
          rev = "1adfd272aaae76850789b6106354492c1f05d3cb";
          hash = "sha256-ytSNQCz7gbKRuY6uiyDriS4tH009xCQaXdkvlB06Z2o=";
        };
        file = "fzf-marks.plugin.zsh";
      }
      {
        name = "forgit";
        src = pkgs.zsh-forgit;
        file = "share/zsh/zsh-forgit/forgit.plugin.zsh";
      }
    ];

    initExtra = ''
      # =============================================================================
      # Dynamic Environment
      # =============================================================================
      export GPG_TTY=$(tty)
      bindkey -e

      [ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--no-height'

      # =============================================================================
      # PATH Configuration
      # =============================================================================
      export PROTO_HOME="$HOME/.proto"
      export PNPM_HOME="$HOME/.local/share/pnpm"
      export FLYCTL_INSTALL="$HOME/.fly"

      path=(
        "$PROTO_HOME/shims"
        "$PROTO_HOME/bin"
        "$PNPM_HOME"
        "$HOME/.local/bin"
        "$HOME/.cache/rebar3/bin"
        "/var/lib/snapd/snap/bin"
        "$HOME/.proto/tools/node/globals/bin"
        "$HOME/.cargo/bin"
        "$FLYCTL_INSTALL/bin"
        $path
      )
      export PATH

      # =============================================================================
      # Secrets via pass (LAZY LOADED - massive speedup)
      # =============================================================================
      # Secrets are loaded on first access, not at shell startup
      # This saves 2-4 seconds of GPG decryption time.
      # Run `load-secrets` explicitly when a CLI tool needs everything at once.

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
        export GITHUB_PERSONAL_ACCESS_TOKEN=$GH_TOKEN
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
      # Exercism OCaml auto-patch
      # =============================================================================
      exercism() {
        local output
        output=$(command exercism "$@" 2>&1)
        echo "$output"
        if [[ "$1" == "download" && "$*" == *"--track=ocaml"* ]]; then
          local dir
          dir=$(echo "$output" | tail -1)
          [[ -d "$dir" ]] || return
          local dune="$dir/dune"
          [[ -f "$dune" ]] || return
          grep -q '^(library' "$dune" && return
          local name=$(basename "$dir" | tr '-' '_')
          cat > "$dune" <<EOF
      (library
       (name $name)
       (modules $name)
       (libraries base))

      (executable
       (name test)
       (modules test)
       (libraries base ounit2 $name))

      (alias
        (name runtest)
        (deps (:x test.exe))
        (action (run %{x})))

      (alias
        (name buildtest)
        (deps (:x test.exe)))

      (env
        (dev
          (flags (:standard -warn-error -A))))
      EOF
          (cd "$dir" && eval $(opam env) && dune build @check) 2>/dev/null
          echo "Patched dune for $name (LSP ready)"
        fi
      }

      # =============================================================================
      # Aliases
      # =============================================================================
      alias nano=nvim
      alias vim=nvim
      alias cat=bat
      alias reload="source ~/.zshrc"
      alias copy='xclip -selection clipboard'

      # Machine-specific xrandr display layouts (this laptop + its dock)
      alias laptopscreen='xrandr --output DP-2 --off --output eDP-1 --auto --primary'
      alias externalscreen='xrandr --output DP-2 --mode 2560x1600 --rate 165'

      # =============================================================================
      # Tool Initialization (with caching where possible)
      # =============================================================================

      # Proto - cache the output
      _proto_cache="$HOME/.cache/proto-init.zsh"
      if [[ ! -f "$_proto_cache" ]] || [[ $(command -v proto) -nt "$_proto_cache" ]]; then
        proto activate zsh > "$_proto_cache" 2>/dev/null
      fi
      [[ -f "$_proto_cache" ]] && source "$_proto_cache"

      # pnpm completions (generated into $HOME by pnpm; unmanaged for now)
      [[ -f ~/completion-for-pnpm.zsh ]] && source ~/completion-for-pnpm.zsh

      # Cache p1-cli completions
      _p1cli_cache="$HOME/.cache/p1-cli-completions.zsh"
      if [[ ! -f "$_p1cli_cache" ]] || [[ $(command -v p1-cli) -nt "$_p1cli_cache" ]]; then
        p1-cli --completions zsh > "$_p1cli_cache" 2>/dev/null
      fi
      [[ -f "$_p1cli_cache" ]] && source "$_p1cli_cache"

      # =============================================================================
      # Vendored Completions & Bindings
      # =============================================================================
      # fzf-gitbindings.zsh is locally modified (--tmux 90%,70%) - the vendored
      # copy in this repo is canonical. Sourced from the nix store so the shell
      # never depends on a repo checkout at runtime.
      source ${./zsh/fzf-gitbindings.zsh}
      source ${./zsh/codex-bindings.zsh}

      # =============================================================================
      # Powerlevel10k Theme Configuration
      # =============================================================================
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --strip-cwd-prefix --follow --hidden -E .git -E node_modules -E .stack-work";
    fileWidgetCommand = "fd --type f --strip-cwd-prefix --follow --hidden -E .git -E node_modules -E .stack-work";
    fileWidgetOptions = [
      "--walker-skip .git,node_modules,target"
      "--preview 'bat -n --color=always {}'"
      "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
    ];
    changeDirWidgetOptions = [
      "--walker-skip .git,node_modules,target"
      "--preview 'tree -C {}'"
    ];
    # CTRL-Y inside CTRL-R copies the command to the clipboard via xclip.
    historyWidgetOptions = [
      "--bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)+abort'"
      "--color header:italic"
      "--header 'Press CTRL-Y to copy command into clipboard'"
    ];
  };

  # Replaces the zsh-direnv plugin and the manual nix-direnv direnvrc hunt.
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
