# Neovim Setup

## Structure

- **Root**: `nvim/.config/nvim`
- **Entry Point**: `init.lua` uses `lazy.nvim` for plugin management. It bootstraps
  the manager if missing, loads shared configs (`configs.lazy`), and applies
  the `onedark_vivid` colorscheme.
- **Key Modules**:
  - `lua/options.lua`: core editor options.
  - `lua/mappings.lua`: all keymaps with descriptions.
  - `lua/autocmds.lua`: event-driven tweaks (document specifics when updated).
  - `plugins/`: plugin specs consumed by Lazy (expand this doc as new plugins
    are added).

## Options Highlights (`options.lua`)

- Leader key: space (`" "`).
- Statusline: global (`laststatus = 3`), disables legacy mode display.
- Clipboard: uses system clipboard (`unnamedplus`).
- Cursor: highlights the current line number (`cursorline`, `cursorlineopt = "number"`).
- Indentation: spaces with 2-width tabs and smart indentation.
- UI: relative numbers, splits open to the right/bottom, signcolumn always on.
- Performance: swapfile disabled, undo files enabled, `updatetime = 250ms`.
- Search: case-insensitive with smart case fallback.
- Providers: disables Node, Python, Perl, and Ruby providers to speed startup.
- PATH: prepends Mason bin directory for LSP/tooling integration.

## Keymaps (`mappings.lua`)

- Window navigation: `<C-h/j/k/l>` for directional movement.
- Convenience: `<C-s>` to save, `<C-c>` to yank entire buffer.
- Twoslash queries: `<leader>st` opens Typescript tooling inspection.
- Quick toggles: `<leader>,` clears search highlights, `jk` exits insert mode,
  `,,` swaps to alternate file.

## Diagnostics

- `init.lua` sets diagnostics to show virtual lines for the current line, giving
  detailed inline feedback without cluttering the buffer.

## Plugin Lockfile

- `lazy-lock.json` pins plugin versions. When updating plugins, review and
  commit the lockfile to keep environments reproducible.

## Future Notes

- Record new plugin categories (LSP, completion, UI) as they are added.
- Capture any custom commands or autocommands in this document so the behavior
  remains transparent when sharing the config.
