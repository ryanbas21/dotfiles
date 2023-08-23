local ok, lsplens = pcall(require, 'lsp-lens')

if not ok then
  return
end

lsplens.setup({
ignore_filetype = {
    "prisma",
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
    "tsx", "jsx", "ts","js"
  },
})
