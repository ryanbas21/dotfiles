# Shell Environment

## Zsh (home-manager)

Zsh is configured in `home/zsh.nix` and imported by `home/ryan.nix`. The
generated `.zshrc` replaces the old zplug-managed `zshrc/.zshrc`, which
remains stowed only until the next activation removes it.

- **Prompt**: Powerlevel10k, sourced from the nixpkgs derivation in
  `initExtraFirst` so the instant prompt stays the first output of the
  generated `.zshrc`. The theme config lives in `home/zsh/p10k.zsh` and is
  deployed as `~/.p10k.zsh` (it was previously unmanaged).
- **Plugins**: managed by home-manager, not zplug.
  - `zsh-autosuggestions` and `zsh-syntax-highlighting` via module options.
  - `forgit` from `pkgs.zsh-forgit`.
  - `fzf-marks` pinned to upstream master via `fetchFromGitHub`.
- **History**: `~/.histfile`, 10000 entries — the same file the old rc used.
- **fzf**: `programs.fzf` provides the keybindings and completion (a single
  `fzf --zsh` load). `fd` lists files, `bat` and `tree` render previews, and
  CTRL-Y inside CTRL-R copies the command through `xclip`.
- **Direnv**: `programs.direnv` with nix-direnv replaces the zsh-direnv
  plugin and the manual direnvrc hunt.

## Secrets

All tokens live in `pass` and load lazily: referencing a variable such as
`CACHIX_AUTH_TOKEN` triggers a one-time `pass show`. Run `load-secrets` to
export everything at once, or call `gh`, which fetches the GitHub token on
first use. Nothing decrypts at shell startup, so a locked GPG agent only
matters when a secret is actually needed. `bin/backup.sh` sources its own
`BORG_PASSPHRASE` from pass (with a fallback) instead of inheriting it from
the shell.

## Environment and PATH

`EDITOR=nvim` and other static variables are set through
`home.sessionVariables`. `GPG_TTY` and the `$HOME`-derived tool roots
(proto, pnpm, flyctl) are exported in `initExtra`, along with the `path`
array ordering: proto shims, proto bin, pnpm, `~/.local/bin`, rebar3, snap,
proto node globals, cargo, and flyctl.

## Tooling kept outside nix

- **proto** is not in nixpkgs; the rc keeps the cached
  `proto activate zsh` pattern under `~/.cache/proto-init.zsh`.
- **pnpm completions** source from `~/.completion-for-pnpm.zsh` when present.
- **p1-cli completions** cache under `~/.cache/p1-cli-completions.zsh`.
- **Vendored files**: `home/zsh/fzf-gitbindings.zsh` (locally modified for
  `--tmux 90%,70%`) and `home/zsh/codex-bindings.zsh` are copied into the
  store and sourced from there, so the shell never depends on a repo
  checkout at runtime.

## Fish (home-manager, shared module)

Fish is now the shared shell config, ported from the NixOS box into
`home/fish.nix` and imported by `home/ryan.nix`. The module is consumed
twice: by this standalone CachyOS flake, and by the NixOS repo, which
imports it nvf-style via the ryan-nvim flake input
(`"${ryan-nvim}/home/fish.nix"`).

The full bundle includes fish plus fzf with the `fzf-fish` plugin and
`fzf-git.sh` (keybindings sourced into `conf.d` from the `fzf-git-sh`
flake input), `starship` for the prompt, `zoxide`, `carapace`, `direnv`
with nix-direnv, and `eza`. The `fzf-fish` plugin needs `fd` at runtime,
so the module ships it in `home.packages` to stay self-contained.

CachyOS activation is still pending: switching the login shell with
`chsh` and running `home-manager switch` remain to be done. The zsh port
in `home/zsh.nix` stays dormant as a fallback until then.

## Still stow-managed

The `zshrc/` package now only ships `.zshrc` itself; it is superseded by
home-manager and will be removed when the migration activates.
