local ok, lightbulb = pcall(require, 'lighbulb');

if not ok then
  return
end


lightbulb.setup({
  autocmd = { enabled = true }
})
