return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      nix = { "nixpkgs-fmt" },
      lua = { "luaformatter", "stylua", stop_after_first = true },
      css = { "prettierd", stop_after_first = true },
      elm = { "elm_format", stop_after_first = true },
      ocaml = { "ocamlformat", stop_after_first = true },
      yaml = { "yamlfix", stop_after_first = true },
      markdown = { "mdformat", stop_after_first = true },
      haskell = { "ormolu", stop_after_first = true },
      html = { "prettierd", "prettier", "biome", stop_after_first = true },
      typescript = { "prettierd", "biome", stop_after_first = true },
      javascript = { "prettierd", "biome", stop_after_first = true },
      typescriptreact = { "prettierd", "biome", stop_after_first = true },
      json = { "prettierd", stop_after_first = true },
      javascriptreact = { "prettierd", "biome", stop_after_first = true },
      purescript = { "purs-tidy", stop_after_first = true },
      luals = { "stylua", stop_after_first = true },
      ["_"] = { "trim_whitespace", stop_after_first = true },
    },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}
