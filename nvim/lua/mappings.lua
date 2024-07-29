require "nvchad.mappings"
local neogit = require "neogit"
local neotest = require "neotest"

-- add yours here

local g = vim.g
local map = vim.keymap.set

map("n", "<leader>st", "<cmd>TwoslashQueriesInspect<CR>", { silent = true })
map("n", "<leader>,", ":nohl<CR>")
map("i", "jk", "<ESC>")
map("n", ",,", "<C-6>")
map("n", "<Leader>;", "<cmd>Telescope live_grep<CR>")
map("n", "<leader>gs", neogit.open, { noremap = true })

map("n", "K", require("hover").hover, { desc = "hover.nvim" })
map("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })

-- Mouse support
map("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })
vim.o.mousemoveevent = true

local mappings = {
  ["<leader>nr"] = function()
    neotest.run.run(vim.fn.expand "%")
  end,
  ["<leader>ns"] = function()
    for _, adapter_id in ipairs(neotest.run.adapters()) do
      neotest.run.run { suite = true, adapter = adapter_id }
    end
  end,
  ["<leader>nw"] = function()
    neotest.watch.watch()
  end,
  ["<leader>nx"] = function()
    neotest.run.stop()
  end,
  ["<leader>nn"] = neotest.run.run,
  ["<leader>nl"] = neotest.run.run_last,
  ["<leader>nD"] = function()
    neotest.run.run_last { strategy = "dap" }
  end,
  ["<leader>na"] = neotest.run.attach,
  ["<leader>no"] = function()
    neotest.output.open { enter = true }
  end,
  ["<leader>nO"] = function()
    neotest.output.open { enter = true, short = true }
  end,
  ["<leader>np"] = neotest.summary.toggle,
  ["<leader>nm"] = neotest.summary.run_marked,
  ["[n"] = function()
    neotest.jump.prev { status = "failed" }
  end,
  ["]n"] = function()
    neotest.jump.next { status = "failed" }
  end,
}

for keys, mapping in pairs(mappings) do
  map("n", keys, "", { callback = mapping, noremap = true })
end
