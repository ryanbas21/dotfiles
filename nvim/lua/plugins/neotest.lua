return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "marilari88/neotest-vitest",
    'nvim-neotest/neotest-jest',
    -- "thenbe/neotest-playwright",
  },
  opt = {
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
      strategies = {
        integrated = {
          width = 180,
        },
      },
      adapters = {
        ["neotest-vitest"] = {},
        ["neotest-jest"] = {}
      }
    }
}
