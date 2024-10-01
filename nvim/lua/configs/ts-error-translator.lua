local ok, plugin = pcall(require, "ts-error-translator")

if not ok then
  return
end

plugin.setup()
