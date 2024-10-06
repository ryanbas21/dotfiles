local ok, lint = pcall(require, "lint")

if not ok then
  return
end

lint.linters_by_ft = {
  javascript = { "eslintd" },
  typescript = { "eslintd" },
  typescriptreact = { "eslintd" },
  javascriptreact = { "eslintd" },
  angular = { "eslintd" },
  bash = { "bash" },
  git = { "gitlint" },
  markdown = { "markdownlint" },
}
