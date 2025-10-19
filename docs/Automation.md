# Automation & MCP Integrations

## Dotfiles Deployment

- **Recommended Flow**:
  1. Clone this repository to `~/dotfiles`. Stow expects that path, so avoid
     renaming it.
  2. Manually run GNU Stow against any top-level module you want to activate,
     e.g. `stow ghostty`, `stow nvim`, `stow zshrc`. Using targeted commands
     keeps surprises low.
  3. When removing a module, use `stow -D <module>` first so symlinks are cleaned
     up before editing or deleting files.
  4. Reload the relevant service manually (`i3-msg reload`, `pkill picom`, etc.)
     after large changes.
- **Why No Script?** Automating Stow with `--adopt` was convenient but easy to
  misuse. Explicit commands make it clear which modules are being linked and
  avoid unintended adoption of files outside this repo.
- **Tips**:
  - Keep a short shell alias for commonly linked groups (e.g., `stow i3 picom polybar`).
  - Add new directories here only after they are ready to be stowed; empty
    folders can be skipped.

## MCP Hub Configuration

- **File**: `mcphub/.config/mcphub/servers.json`
- **Purpose**: Defines Model Context Protocol servers used across tooling.
- **Key Servers**:
  - `brave-search` (npx, auto-approves search actions, pulls key from
    `$BRAVE_API_KEY`).
  - `chrome-devtools` for browser automation with extensive auto approvals.
  - `context7`, `package-registry`, `effect-mcp`, `nx-mcp` and others for
    documentation, registries, and frameworks.
  - `filesystem` exposes key directories via MCP (note: includes `~/.config`
    paths).
  - `github` HTTP bridge seeded with the `GITHUB_TOKEN`.
- **Security**: Environment values reference password store (`pass`) entries or
  existing shell variables—never hardcode secrets in the JSON.

## Codex CLI

- **Config**: `codex/.codex/config.toml`
- **Highlights**:
  - Marks trusted project roots (including this dotfiles repo).
  - Sets shell environment policy to inherit all variables and skips default
    exclusion filters (useful for pass-sourced secrets).
  - Mirrors the MCP server list, providing CLI access to the same automation
    endpoints.
- **Logs**: `codex/.codex/log/codex-tui.log` captures CLI session traces; rotate
  or prune as needed.

## Logging & Misc

- `logs/` holds tooling outputs; decide on rotation strategy before it grows.
- `etc/` reserved for system-level configs (add documentation when populated).
- `ghostty/`, `nvim/`, and other directories are stowed automatically—ensure any
  helper scripts referenced in the docs live alongside their configs so the
  setup script captures them.
