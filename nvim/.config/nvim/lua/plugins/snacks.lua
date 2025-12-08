return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false, -- this should not be lazy!
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = {
      enabled = true,
      replace_netrw = true, -- Replace netrw with the snacks explorer
    },
    indent = { enabled = true },
    input = { enabled = true },
    picker = {
      enabled = true,
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
    -- Explorer
    { "<C-n>", function() Snacks.explorer.open() end, desc = "Explorer" },
    -- Picker (replaces telescope)
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
    { "<leader><leader>", function() Snacks.picker.git_files() end, desc = "Git files" },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>;", function() Snacks.picker.lines() end, desc = "Buffer lines" },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "Help" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent files" },
    { "<leader>fc", function() Snacks.picker.git_log() end, desc = "Git commits" },
    { "<leader>th", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
  },
}
