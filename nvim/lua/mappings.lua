require "nvchad.mappings"
local neogit = require "neogit"
local neotest = require "neotest"

local g = vim.g
local map = vim.keymap.set

map("n", "<leader>st", "<cmd>TwoslashQueriesInspect<CR>", { silent = true })
map("n", "<leader>,", ":nohl<CR>")
map("i", "jk", "<ESC>")
map("n", ",,", "<C-6>")
map("n", "<Leader>;", "<cmd>Telescope live_grep<CR>")
map("n", "<leader>gs", neogit.open, { noremap = true })

map("n", "<leader>nr", function()
  neotest.run.run(vim.fn.expand "%")
end, { desc = "Neotest run" })

map("n", "<leader>ns", function()
  for _, adapter_id in ipairs(neotest.run.adapters()) do
    neotest.run.run { suite = true, adapter = adapter_id }
  end
end, { desc = "neotest run adapters" })
map("n", "<leader>nw", neotest.watch.watch, { desc = "neotest watch" })

map("n", "<leader>nx", neotest.run.stop, { desc = "neotest stop" })

map("n", "<leader>nn", neotest.run.run, { desc = "neotest run" })

map("n", "<leader>nl", neotest.run.run_last, { desc = "neotest run last" })

map("n", "<leader>nD", function()
  neotest.run.run_last { strategy = "dap" }
end, { desc = "neotest run last dap" })

map("n", "<leader>na", neotest.run.attach, { desc = "neotest attach" })

map("n", "<leader>no", function()
  neotest.output.open { enter = true }
end, { desc = "neotest output open" })

map("n", "<leader>nO", function()
  neotest.output.open { enter = true, short = true }
end, { desc = "neotest short output open" })

map("n", "<leader>np", neotest.summary.toggle, { desc = "neotest toggle summary" })

map("n", "<leader>nm", neotest.summary.run_marked, { desc = "neotest run marked" })

map("n", "[n", function()
  neotest.jump.prev { status = "failed" }
end, { desc = "neotest jump to previous failed" })

map("n", "]n", function()
  neotest.jump.next { status = "failed" }
end, { desc = "neotest jump to next failed" })
