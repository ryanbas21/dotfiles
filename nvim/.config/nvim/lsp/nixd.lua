---@type vim.lsp.Config
return {
  cmd = { "nixd" },
  filetypes = { "nix" },
  settings = {
    nixd = {
      formatting = { command = { "nixpkgs-fmt" } },
    },
  },
}
