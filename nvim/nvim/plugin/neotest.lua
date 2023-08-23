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
            env = { CI = true },
            cwd = function(path)
                return vim.loop.cwd()
            end,
      }),
      require('neotest-vitest'),
      require("neotest-rust"),
      require("neotest-playwright").adapter({
        -- default values shown
        options = {
          persist_project_selection = false,

          enable_dynamic_test_discovery = false,

          preset = "none", -- "none" | "headed" | "debug"

        },
      }),
      require("neotest-plenary"),
    },
  })


