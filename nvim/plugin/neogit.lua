local ok, neogit = pcall(require, 'neogit')
if not ok then
  return
end

neogit.setup {
  integrations = {
    diffview = true
  }
}

vim.keymap.set("n", "<leader>gs", neogit.open, {noremap=true})
