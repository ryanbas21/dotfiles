# Pi

Manages `~/.pi` for the [pi coding agent](https://github.com/earendil-works/pi-coding-agent).

## What is tracked

- `agent/settings.json` – global settings, theme, extension package list
- `agent/trust.json` – trusted directory allowlist
- `agent/model-router.json` – model router tiers and fallbacks
- `agent/npm/package.json` – npm extension manifest (`.gitignore` beside it keeps `node_modules` out)
- `agent/extensions/pi-rtk-optimizer/config.json` – extension config

## What is intentionally ignored

`auth.json` (API keys), `models-store.json`, `mcp-cache.json` / `mcp-npx-cache.json`, `sessions/`, `web-search-cache/`, and `npm/` lockfile plus `node_modules/` are runtime state or secrets and never enter the repository. The stow package links tracked files individually, so untracked siblings in `~/.pi` stay as plain files.

## Commands

Adopt live changes back into the repo after editing configs directly:

```sh
stow -v --adopt pi
```

Verify links without touching anything:

```sh
stow -nv pi
```
