---@type vim.lsp.Config
return {
  cmd = { vim.fn.expand "$HOME" .. "/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" },
  filetypes = { "elixir", "eelixir", "heex", "surface" },
  root_markers = { "mix.exs", ".git" },
}
