local neotest = require('neotest')
local dap = require('dap')


neotest.setup({
    status = {
      virtual_text = true,
      signs = false,
    },
   icons = {
      expanded = "",
      child_prefix = "",
      child_indent = "",
      final_child_prefix = "",
      non_collapsible = "",
      collapsed = "",

      passed = "",
      running = "",
      failed = "",
      unknown = ""
    },
    strategies = {
      integrated = {
        width = 180,
      },
    },
    adapters = {
      require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.ts",
            env = { CI = true },
            cwd = function(path)
                return vim.loop.cwd()
            end,
      }),
      require('neotest-vitest'),
      require("neotest-plenary"),
    },
  })

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
    vim.api.nvim_set_keymap("n", keys, "", { callback = mapping, noremap = true })
  end

