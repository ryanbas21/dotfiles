return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed, not both.
    "nvim-telescope/telescope.nvim", -- optional
    -- "ibhagwan/fzf-lua", -- optional
  },
  opts = {
    integrations = {
      diffview = true,
    },
  },
  event = "VeryLazy",
  cmd = "Neogit",
  keys = {
    {
      "<leader>gs",
      function()
        require("neogit").open {}
      end,
      desc = "Open neogit",
    },
  },
}
