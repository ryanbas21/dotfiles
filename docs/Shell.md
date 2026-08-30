# Shell Environment

## Zsh (stow)

This repo is a plain GNU Stow repo for the CachyOS desktop. The shell is zsh,
deployed by the `zshrc/` stow package:

- **`.zshrc`**: the live rc, including the PATH ordering (proto shims, proto
  bin, pnpm, `~/.local/bin`, cargo, flyctl) and the cached
  `proto activate zsh` pattern under `~/.cache/proto-init.zsh`.
- **`codex-bindings.zsh`** and **`fzf-gitbindings.zsh`** (locally modified for
  `--tmux 90%,70%`): sourced from `$HOME` by the rc.
- **Prompt**: Powerlevel10k with the instant prompt, configured by
  `~/.p10k.zsh`.
- **History**: `~/.histfile`, 10000 entries.

Optional completions are picked up when present: pnpm completions from
`~/completion-for-pnpm.zsh` and cached p1-cli completions under
`~/.cache/p1-cli-completions.zsh`.

## Secrets

All tokens live in `pass` and load lazily: referencing a variable such as
`CACHIX_AUTH_TOKEN` triggers a one-time `pass show`. Run `load-secrets` to
export everything at once, or call `gh`, which fetches the GitHub token on
first use. Nothing decrypts at shell startup, so a locked GPG agent only
matters when a secret is actually needed. `bin/backup.sh` sources its own
`BORG_PASSPHRASE` from pass (with a fallback) instead of inheriting it from
the shell.

## Nix-managed configuration

The NixOS laptop is fully managed by a separate repo,
[ryanbas21/nixos-configuration](https://github.com/ryanbas21/nixos-configuration).
That repo owns the fish shell setup and the nvf/Neovim configuration for the
`batman` user. Neovim's lua tree still lives here in `nvim/` — the nixos repo
consumes it read-only through its `ryan-nvim` flake input, so edits to
`nvim/` propagate on the next lock bump there.
