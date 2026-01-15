local g = vim.g
local map = vim.keymap.set

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

map("n", "<leader>st", "<cmd>TwoslashQueriesInspect<CR>", { silent = true, desc = "Twoslash queries inspect" })
map("n", "<leader>,", ":nohl<CR>")
map("i", "jk", "<ESC>")
map("n", ",,", "<C-6>")

-- ESLint fix current file (works for JSON and other eslint_d supported files)
map("n", "<leader>ef", function()
  local file = vim.fn.expand("%:p")
  vim.cmd("silent !eslint_d --fix " .. vim.fn.shellescape(file))
  vim.cmd("edit") -- reload the buffer
end, { desc = "ESLint fix current file" })
