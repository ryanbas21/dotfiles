# Shell Environment

## Zsh

- **Config**: `zshrc/.zshrc`
- **Plugin Manager**: `zplug` bootstraps itself if missing, then loads:
  - `powerlevel10k` theme
  - `zsh-autosuggestions`
  - `zsh-syntax-highlighting`
  - `forgit`, `fzf-marks`, and `zsh-direnv`
- **Prompt**: Powerlevel10k with instant prompt enabled (`POWERLEVEL9K_INSTANT_PROMPT=quiet`).
- **Aliases**:
  - `nano → nvim`, `vim → nvim`
  - `cat → bat` for syntax-highlighted previews
  - Monitor helpers (`laptopscreen`, `externalscreen`) wrapping `xrandr`
  - `reload` to source the shell config
- **Secrets**:
  - All API tokens live in `pass`. `~/.zshrc` sources them automatically and
    relies on the GPG agent being unlocked. If you boot into a context where
    `pass` is unavailable, expect the shell to warn—unlock the keychain before
    running commands that need the tokens.
- **Environment**:
  - `EDITOR=nvim`, terminal set to `xterm-256color`.
  - PATH augmented for pnpm, proto, opam, cargo, ghcup, rebar3, direnv, and
    general local bins.
  - NVM initialized when present.
- **FZF Configuration**:
  - Defaults use `fd` for listing and `bat` for previews.
  - CTRL-T, ALT-C, and CTRL-R integrations customize preview/clipboard actions.
- **Direnv**:
  - Cross-platform `DIRENV_BASH` selection (macOS vs Linux).
  - Loads standard direnv hooks and Nix direnv stdlib if available.
- **Codex Integration**: Custom bindings sourced from
  `~/codex-bindings.zsh` along with completion scripts.
- **Next Steps**: Document additional helper scripts under `zshrc/` as they are
  added so the shell story stays complete.
