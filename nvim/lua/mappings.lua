require "nvchad.mappings"
local neogit = require "neogit"

local g = vim.g
local map = vim.keymap.set

map("n", "<leader>st", "<cmd>TwoslashQueriesInspect<CR>", { silent = true })
map("n", "<leader>,", ":nohl<CR>")
map("i", "jk", "<ESC>")
map("n", ",,", "<C-6>")
map("n", "<Leader>;", "<cmd>Telescope live_grep<CR>")
map("n", "<leader>gs", neogit.open, { noremap = true })
map("n", "<leader>rn", ":IncRename ", { noremap = true })
