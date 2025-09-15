return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "marilari88/neotest-vitest",
    "nvim-neotest/neotest-jest",
    "thenbe/neotest-playwright",
  },
  cmd = "Neotest",
  keys = {
    { "<leader>t", "", desc = "+test" },
    {
      "<leader>tr",
      function()
        require("neotest").run.run(vim.fn.expand "%")
      end,
      desc = "Run File",
      nnoremap = true,
    },
    {
      "<leader>tT",
      function()
        require("neotest").run.run(vim.uv.cwd())
      end,
      desc = "Run All Test Files",
    },
    {
      "<leader>tr",
      function()
        require("neotest").run.run()
      end,
      desc = "Run Nearest",
    },
    {
      "<leader>tl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Run Last",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle Summary",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open { enter = true, auto_close = true }
      end,
      desc = "Show Output",
    },
    {
      "<leader>tO",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle Output Panel",
    },
    {
      "<leader>tS",
      function()
        require("neotest").run.stop()
      end,
      desc = "Stop",
    },
    {
      "<leader>tw",
      function()
        require("neotest").watch.toggle(vim.fn.expand "%")
      end,
      desc = "Toggle Watch",
    },
  },
  config = function()
    require("neotest").setup {
      status = {
        virtual_text = true,
        signs = true,
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
        unknown = "",
      },
      quickfix = {
        open = function()
          vim.cmd "Trouble quickfix"
        end,
        enabled = false,
      },
      adapters = {
        require "mrcjkb/neotest-haskell" {
          -- Default: Use stack if possible and then try cabal
          build_tools = { "stack", "cabal" },
          -- Default: Check for tasty first and then try hspec
          frameworks = { "tasty", "hspec", "sydtest" },
        },
        require "neotest-vitest" {
          env = { CI = true },
        },
        require "neotest-jest" {},
        require("neotest-playwright").adapter {
          options = {
            persist_project_selection = false,

            enable_dynamic_test_discovery = false,

            preset = "none", -- "none" | "headed" | "debug"

            experimental = {
              telescope = {
                -- If true, a telescope picker will be used for `:NeotestPlaywrightProject`.
                -- Otherwise, `vim.ui.select` is used.
                -- In normal mode, `<Tab>` toggles the project under the cursor.
                -- `<CR>` (enter key) applies the selection.
                enabled = true,
                opts = {},
              },
            },
          },
        },
        require "codymikol/neotest-kotlin" {},
        require "arthur944/neotest-bun" {},
      },
    }
  end,
}
