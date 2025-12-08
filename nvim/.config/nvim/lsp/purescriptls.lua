---@type vim.lsp.Config
return {
  cmd = { "purescript-language-server", "--stdio" },
  filetypes = { "purescript" },
  root_markers = { "spago.dhall", "spago.yaml", "bower.json", "psc-package.json", ".git" },
  settings = {
    purescript = {
      formatter = "purs-tidy",
    },
  },
}
