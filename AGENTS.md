# Repository Guidelines

## Project Structure & Module Organization
Configuration is grouped by GNU Stow packages. Each top-level directory mirrors the target filesystem fragment: e.g. `alacritty/.config/alacritty/alacritty.toml` feeds `~/.config/alacritty/alacritty.toml`, while `bin/.local/bin/*` installs helper scripts into `~/.local/bin`. Documentation lives under `docs/` and should be updated whenever you change an associated config. Leave non-stowable artifacts (`logs/`, private keys) untouched unless explicitly instructed.

## Build, Test, and Development Commands
There is no compile step. Use Stow to link packages into place: `stow -nv alacritty` (dry-run) and `stow -v alacritty` (apply). When cleaning up linked files, prefer `stow -Dv <package>`. For shell scripts in `bin/.local/bin`, run them directly (`./osd-volume -5`) to validate behavior after edits. Use `rg` for fast repository searches and `fd` for file discovery, matching the tools preconfigured in `zshrc/.zshrc`.

## Coding Style & Naming Conventions
Follow the existing style per language. Bash scripts use `#!/usr/bin/env bash`, `set -euo pipefail`, two-space indentation, and long-form command names. LUA files under `nvim/.config/nvim` follow Neovim conventions: snake_case for locals and declarative plugin specs. Keep Stow directories aligned with XDG paths (e.g. `.config/<app>`). For documentation under `docs/`, favor short sections with American English spelling.

## Testing Guidelines
Before submitting changes, run `stow -nv <package>` to ensure symlinks will land correctly and flag collisions. For shell utilities, run `shellcheck bin/.local/bin/<script>` when available to catch common issues. Launch Neovim (`nvim --headless -c 'quit'`) to confirm Lua syntax loads without errors. Manual smoke tests (triggering i3/polybar reloads, exercising scripts) remain essential because many configs are runtime-driven.

## Commit & Pull Request Guidelines
Write commits in the conventional imperative form (`Fix volume OSD thresholds`). Squash incidental changes; each commit should map to one logical tweak. Reference related documentation updates in the same commit whenever possible. Pull requests should include: a concise summary of the change, impacted Stow packages, verification steps (e.g. `stow -nv bin`), and screenshots for visual components like Polybar or Rofi when behavior changes.
