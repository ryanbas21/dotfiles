return {
  "lewis6991/gitsigns.nvim",
  lazy = true,
  keys = {
    {
      "<leader>td",
      function()
        require("gitsigns").toggle_deleted {}
      end,
      desc = "Git toggle deleted",
    },
    {
      "<leader>hD",
      function()
        require("gitsigns").diffthis "~"
      end,
      desc = "Git diff buffer",
    },
    {
      "<leader>hs",
      function()
        require("gitsigns").stage_hunk()
      end,
      desc = "Stage Hunk",
    },
    {
      "<leader>hr",
      function()
        require("gitsigns").reset_hunk { vim.fn.line ".", vim.fn.line "v" }
      end,
      desc = "reset hunk",
    },
    {
      "<leader>hS",
      function()
        require("gitsigns").stage_buffer {}
      end,
      desc = "stage buffer",
    },
    {
      "<leader>hd",
      function()
        require("gitsigns").diffthis {}
      end,
      desc = "Git diff buffer",
    },
    {
      "<leader>tb",
      function()
        require("gitsigns").toggle_current_line_blame {}
      end,
      desc = "Git toggle blame line",
    },
    {
      "<leader>hb",
      function()
        require("gitsigns").blame_line { full = true }
      end,
      desc = "Git blame full line",
    },
    {
      "<leader>hR",
      function()
        require("gitsigns").preview_hunk {}
      end,
      desc = "Preview Hunk",
    },
    {
      "<leader>hR",
      function()
        require("gitsigns").reset_buffer {}
      end,
      desc = "Reset Buffer",
    },
    {
      "<leader>hu",
      function()
        require("gitsigns").undo_stage_hunk {}
      end,
      desc = "undo stage hunk",
    },
    {
      "<leader>hn",
      function()
        require("gitsigns").next_hunk {}
      end,
      desc = "next_hunk",
    },
    {
      "<leader>hp",
      function()
        require("gitsigns").prev_hunk {}
      end,
      desc = "prev_hunk",
    },
  },
}
