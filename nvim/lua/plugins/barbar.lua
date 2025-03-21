return {
  "romgrk/barbar.nvim",
  event = "BufEnter",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
    animation = true,
    insert_at_start = true,
  },
  keys = {
    -- Move buffer position
    { "<leader>>", "<Cmd>BufferMovePrevious<CR>", desc = "Move buffer left", mode = "n", silent = true },
    { "<leader><", "<Cmd>BufferMoveNext<CR>", desc = "Move buffer right", mode = "n", silent = true },

    -- Go to specific buffer position
    { "<A-1>", "<Cmd>BufferGoto 1<CR>", desc = "Go to buffer 1", mode = "n", silent = true },
    { "<A-2>", "<Cmd>BufferGoto 2<CR>", desc = "Go to buffer 2", mode = "n", silent = true },
    { "<A-3>", "<Cmd>BufferGoto 3<CR>", desc = "Go to buffer 3", mode = "n", silent = true },
    { "<A-4>", "<Cmd>BufferGoto 4<CR>", desc = "Go to buffer 4", mode = "n", silent = true },
    { "<A-5>", "<Cmd>BufferGoto 5<CR>", desc = "Go to buffer 5", mode = "n", silent = true },
    { "<A-6>", "<Cmd>BufferGoto 6<CR>", desc = "Go to buffer 6", mode = "n", silent = true },
    { "<A-7>", "<Cmd>BufferGoto 7<CR>", desc = "Go to buffer 7", mode = "n", silent = true },
    { "<A-8>", "<Cmd>BufferGoto 8<CR>", desc = "Go to buffer 8", mode = "n", silent = true },
    { "<A-9>", "<Cmd>BufferGoto 9<CR>", desc = "Go to buffer 9", mode = "n", silent = true },
    { "<A-0>", "<Cmd>BufferLast<CR>", desc = "Go to last buffer", mode = "n", silent = true },
  },
  version = "^1.0.0", -- optional: only update when a new 1.x version is released
}
