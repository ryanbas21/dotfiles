return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false, -- this should not be lazy!
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = {
      enabled = true,
      replace_netrw = true, -- Replace netrw with the snacks explorer
    },
    indent = { enabled = true },
    input = { enabled = true },
    picker = {
      enabled = false,
    },
    rename = { enabled = false },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    zen = { enabled = false },
  },
  keys = {
    {
      "<C-n>",
      function()
        require("snacks").explorer.open()
      end,
      desc = "Open Snacks Explorer",
    },
  },
}
