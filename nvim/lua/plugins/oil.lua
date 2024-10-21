return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  keys = {
    {
      "-",
      "<CMD>Oil --float<CR>",
      { desc = "Open parent directory" },
    },
  },
}
