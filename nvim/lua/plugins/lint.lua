return {
  "mfussenegger/nvim-lint",
  opt = {
    linters_by_ft = {
      javascript = { "eslintd" },
      typescript = { "eslintd" },
      typescriptreact = { "eslintd" },
      javascriptreact = { "eslintd" },
      angular = { "eslintd" },
      bash = { "bash" },
      git = { "gitlint" },
      markdown = { "markdownlint" },
    }
  }
}
