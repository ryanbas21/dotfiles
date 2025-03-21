return {
  "mfussenegger/nvim-lint",
  event = { "BufRead" },
  config = function()
    require("lint").linters_by_ft = {
      javascript = { "eslint_d", "biome" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      angular = { "eslint_d" },
      bash = { "bash" },
      git = { "gitlint" },
      markdown = { "markdownlint" },
    }
  end,
}
