local ok, autopairs = pcall(require, "nvim-autopairs")
if not ok then
  return
end

autopairs.setup({
  enable_check_bracket_line = false,
  ignored_next_char = "[%w%.]",
  disable_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input" },
})

vim.cmd("autocmd FileType guihua lua require('cmp').setup.buffer { enabled = false }")
vim.cmd("autocmd FileType guihua_rust lua require('cmp').setup.buffer { enabled = false }")
