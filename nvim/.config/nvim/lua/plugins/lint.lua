return {
  "mfussenegger/nvim-lint",
  event = { "BufRead" },
  config = function()
    require("lint").linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      angular = { "eslint_d" },
      bash = { "bash" },
      git = { "gitlint" },
      yaml = { "yamllint" },
      python = { "ruff" },
      eslint_d = { "eslint_d" },
      lua = { "luacheck" },
      css = { "stylelint" },
    }
  end,
}
