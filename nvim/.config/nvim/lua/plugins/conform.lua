return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      css = { "prettierd", stop_after_first = true },
      elm = { "elm_format" },
      ocaml = { "ocamlformat" },
      yaml = { "yamllint" },
      markdown = { "mdformat" },
      haskell = { "ormolu" },
      html = { "prettierd", "prettier", "biome", stop_after_first = true },
      typescript = { "prettierd", "prettier", "biome", stop_after_first = true },
      javascript = { "prettierd", "prettier", "biome", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", "biome", stop_after_first = true },
      json = { "fixjson" },
      javascriptreact = { "prettierd", "prettier", "biome", stop_after_first = true },
      luals = { "stylua" },
      -- Use the "*" filetype to run formatters on all filetypes.
      -- ["*"] = { "codespell" },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      ["_"] = { "trim_whitespace" },
    },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}
