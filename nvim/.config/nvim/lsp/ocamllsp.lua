---@type vim.lsp.Config
return {
  cmd = { "ocamllsp" },
  filetypes = { "ocaml", "menhir", "ocamlinterface", "ocamllex", "reason", "dune" },
  root_markers = { "*.opam", "esy.json", "package.json", "dune-project", "dune-workspace", ".git" },
}
