return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  opts = {
    integrations = {
      diffview = true,
    },
  },
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
