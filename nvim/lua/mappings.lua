require "nvchad.mappings"

local g = vim.g
local map = vim.keymap.set

map("n", "<leader>st", "<cmd>TwoslashQueriesInspect<CR>", { silent = true })
map("n", "<leader>,", ":nohl<CR>")
map("i", "jk", "<ESC>")
map("n", ",,", "<C-6>")

-- new terminals
map("n", "<leader>ot", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })
