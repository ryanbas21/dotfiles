---@type vim.lsp.Config
return {
  cmd = { "haskell-language-server-wrapper", "--lsp", "+RTS", "-M8G", "-RTS" },
  filetypes = { "haskell", "lhaskell" },
  root_markers = { "hie.yaml", "stack.yaml", "cabal.project", "*.cabal", "package.yaml" },
  settings = {
    haskell = {
      formattingProvider = "ormolu",
      checkProject = false,
    },
  },
}
