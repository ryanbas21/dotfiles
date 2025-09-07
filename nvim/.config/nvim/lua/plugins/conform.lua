return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "luaformatter", "stylua" },
      css = { "prettierd", stop_after_first = true },
      elm = { "elm_format" },
      ocaml = { "ocamlformat" },
      yaml = { "yamlfix" },
      markdown = { "mdformat" },
      haskell = { "ormolu" },
      html = { "prettierd", "prettier", "biome", stop_after_first = true },
      typescript = { "prettierd", "biome", stop_after_first = true },
      javascript = { "prettierd", "biome", stop_after_first = true },
      typescriptreact = { "prettierd", "biome", stop_after_first = true },
      json = { "fixjson" },
      javascriptreact = { "prettierd", "biome", stop_after_first = true },
      purescript = { "purs-tidy" },
      luals = { "stylua" },
      ["_"] = { "trim_whitespace" },
    },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}
