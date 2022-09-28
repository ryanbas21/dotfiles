local ok, copilot = pcall(require, "copilot")
if not ok then
  return
end

vim.defer_fn(function()
  copilot.setup({
    panel = {
      refresh = true
    }
  })
  require('copilot_cmp').setup {
  method = "getCompletionsCycling",
}
end, 100)


