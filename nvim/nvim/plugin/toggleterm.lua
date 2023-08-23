local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
    return
end

toggleterm.setup {
    insert_mappings = false,
    env = {
        MANPAGER = "less -X",
    },
    terminal_mappings = false,
    start_in_insert = true,
    persist_mode = true,
    persist_size = false,
    open_mapping = [[<space>t]],
    highlights = {
        CursorLineSign = { link = "DarkenedPanel" },
    },
}
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
