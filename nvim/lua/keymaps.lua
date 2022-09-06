local g = vim.g
local keymap = vim.keymap.set

g.mapleader = ' '

keymap("n", ",,", "<C-^>", { noremap = true })
keymap("n", "<leader>e", ":e <C-R>=expand('%:p:') . '/' <CR>", { noremap = true })

-- Move around splits using Ctrl + {h,j,k,l}
keymap('n', '<C-h>', '<C-w>h', { noremap = true })
keymap('n', '<C-j>', '<C-w>j', { noremap = true })
keymap('n', '<C-k>', '<C-w>k', { noremap = true })
keymap('n', '<C-l>', '<C-w>l', { noremap = true })
keymap('i', 'jk', '<Esc>', { noremap = true })
keymap('n', 'YY', '"+y<CR>', { noremap = true })

keymap('n', '<Leader>,', '<cmd>nohl<CR>', { noremap = true })
keymap('n', 'Y', 'y$', { noremap = true })

keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
keymap("n", "gp", '<cmd>Lspsaga preview_definition<CR>', { silent = true })
keymap("n", "<leader>lj", "<cmd>Lspsaga diagnostic_jump_next<cr>", { silent = true, noremap = true })
keymap("n", "<leader>lk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { silent = true, noremap = true })
-- Show cursor diagnostic
keymap("n", "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
-- Diagnsotic jump can use `<c-o>` to jump back
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
keymap("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
