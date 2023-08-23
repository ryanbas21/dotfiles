local bufferline = require "bufferline"
local hover = require "hover"
local files = require "telescope_config.find_files"
local neogit = require "neogit"
local buffers = require "telescope_config.buffers"
local git = require "telescope_config.git"
local neotest = require('neotest')
local trouble = require "trouble"

local g = vim.g
local keymap = vim.keymap.set

g.mapleader = ' '

keymap("i", "jk", "<Esc>")
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

local opts = { noremap = true, silent = true }
keymap("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
-- Lua
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)
keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  {silent = true, noremap = true}
)
keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)
keymap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
  {silent = true, noremap = true}
)
keymap("n", "[d", function ()
  trouble.next({ jump = true, skip_groups = true })
end);

keymap("n", "]d", function()
  trouble.previous({ jump = true, skip_groups = true })
end
);



keymap("n", "<leader>r", "<cmd>Telescope resume<CR>", { noremap = true })
keymap("n", "<leader><leader>", files.git_files, { noremap = true })
keymap("n", "<leader>f", files.find, { noremap = true })
keymap("n", "<leader>b", files.buffers, { noremap = true })
keymap("n", "<Leader>;", buffers.buffer_fuzzy_find, { noremap = true })
keymap("n", "<leader>bc", git.buffer_commits, { noremap = true })
keymap("n", "<leader>S", buffers.grep_cursor, { noremap = true })
keymap("n", "<leader>s", buffers.search_string, { noremap = true })
keymap("n", "<leader>;", buffers.buffer_fuzzy_find, { noremap = true })

keymap("n", "<leader>lq", "<cmd>LBQuestions<cr>")
keymap("n", "<leader>ll", "<cmd>LBQuestion<cr>")
keymap("n", "<leader>lr", "<cmd>LBReset<cr>")
keymap("n", "<leader>lt", "<cmd>LBTest<cr>")
keymap("n", "<leader>ls", "<cmd>LBSubmit<cr>")

keymap(
	{"n", "x"},
	"<leader>rr",
	function() require('telescope').extensions.refactoring.refactors() end
)

keymap("n", "K", hover.hover, {desc = "hover.nvim"})
keymap("n", "gK", hover.hover_select, { desc = "hover.nvim (select)" })
keymap("n", "<C-n>", "<cmd>Neotree toggle left<cr>")
keymap("n", "<leader>gs", neogit.open, {noremap=true})

-- neotest
  local mappings = {
    ["<leader>nr"] = function()
      neotest.run.run(vim.fn.expand("%"))
    end,
    ["<leader>ns"] = function()
      for _, adapter_id in ipairs(neotest.run.adapters()) do
        neotest.run.run({ suite = true, adapter = adapter_id })
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
      neotest.run.run_last({ strategy = "dap" })
    end,
    ["<leader>na"] = neotest.run.attach,
    ["<leader>no"] = function()
      neotest.output.open({ enter = true })
    end,
    ["<leader>nO"] = function()
      neotest.output.open({ enter = true, short = true })
    end,
    ["<leader>np"] = neotest.summary.toggle,
    ["<leader>nm"] = neotest.summary.run_marked,
    ["[n"] = function()
      neotest.jump.prev({ status = "failed" })
    end,
    ["]n"] = function()
      neotest.jump.next({ status = "failed" })
    end,
  }

  for keys, mapping in pairs(mappings) do
    keymap("n", keys, "", { callback = mapping, noremap = true })
  end


-- bufferline
keymap('n', '[b', '<cmd>BufferLineCycleNext<CR>', { noremap = true})
keymap('n', ']b', '<cmd>BufferLineCyclePrev<CR>', { noremap = true })

-- " These commands will sort buffers by directory, language, or a custom criteria
keymap('n', '<leader>bse', function()
                              bufferline.sort_buffers_by('extension')
                            end
      )
keymap('n', '<leader>bsd', function()
                            bufferline.sort_buffers_by('directory')
                          end
      )
keymap('n', '<leader>bst', function()
                            bufferline.sort_buffers_by('tabs')
                          end
      )

keymap('n', '<leader>1', function()
                            bufferline.go_to_buffer('1', true)
                          end
      )
keymap('n', '<leader>2', function()
                            bufferline.go_to_buffer('2', true)
                          end
      )
keymap('n', '<leader>3', function()
                            bufferline.go_to_buffer('3', true)
                          end
      )
keymap('n', '<leader>4', function()
                            bufferline.go_to_buffer('4', true)
                          end
      )
keymap('n', '<leader>5', function()
                            bufferline.go_to_buffer('5', true)
                          end
      )
keymap('n', '<leader>6', function()
                            bufferline.go_to_buffer('6', true)
                          end
      )
keymap('n', '<leader>7', function()
                            bufferline.go_to_buffer('7', true)
                          end
      )
keymap('n', '<leader>8', function()
                            bufferline.go_to_buffer('8', true)
                          end
      )
keymap('n', '<leader>9', function()
                            bufferline.go_to_buffer('9', true)
                          end
      )
keymap('n', '<leader>0', function()
                            bufferline.go_to_buffer('-1', true)
                          end
      )

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

local opts = { noremap = true, silent = true }
keymap("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
-- Lua
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)
keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  {silent = true, noremap = true}
)
keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)
keymap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
  {silent = true, noremap = true}
)
