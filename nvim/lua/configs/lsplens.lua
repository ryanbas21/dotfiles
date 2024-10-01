local ok, lsplens = pcall(require, "lsp-lens")

if not ok then
  return
end

lsplens.setup {}

