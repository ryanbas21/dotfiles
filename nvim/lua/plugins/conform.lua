return {
  "stevearc/conform.nvim",
  lazy = false,
  opt = {
    formatters_by_ft = {
      lua = { "stylua" },
      css = { "prettier", "biome", stop_after_first = true },
      html = { "prettierd", "prettier", "biome", stop_after_first = true },
      typescript = { "prettier", "biome", stop_after_first = true },
      javascript = { "prettier", "biome", stop_after_first = true },
      typescriptreact = { "prettier", "biome", stop_after_first = true },
      javascriptreact = { "prettier", "biome", stop_after_first = true },
      luals = { "stylua" },
      -- Use the "*" filetype to run formatters on all filetypes.
      ["*"] = { "codespell" },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      ["_"] = { "trim_whitespace" },
    },
  },
}
