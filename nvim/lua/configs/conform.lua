local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettierd", "biome" },
    html = { "prettierd", "biome" },
    typescript = { "prettierd", "biome" },
    javascript = { "prettierd", "biome" },
    typescriptreact = { "prettierd", "biome" },
    javascriptreact = { "prettierd", "biome" },
    luals = { "stylua " },
    -- Use the "*" filetype to run formatters on all filetypes.
    ["*"] = { "codespell" },
    -- Use the "_" filetype to run formatters on filetypes that don't
    -- have other formatters configured.
    ["_"] = { "trim_whitespace" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
