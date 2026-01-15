local mason_bin = vim.fn.stdpath "data" .. "/mason/bin"

---@type vim.lsp.Config
return {
  cmd = { mason_bin .. "/vscode-eslint-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { ".eslintrc", ".eslintrc.js", ".eslintrc.json", "eslint.config.js", "eslint.config.mjs" },
  settings = {
    eslint = {
      useFlatConfig = true,
    },
  },
}
